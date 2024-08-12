//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2024 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import UserNotifications


class SpeziNotificationCenterDelegate: NSObject, @preconcurrency UNUserNotificationCenterDelegate {
#if !os(tvOS)
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        await withTaskGroup(of: Void.self) { @MainActor group in
            // Moving this inside here (@MainActor isolated task group body) helps us avoid making the whole delegate method @MainActor.
            // Apparently having the non-Sendable `UNNotificationResponse` as a parameter to a @MainActor annotated method doesn't suppress
            // the warning with @preconcurrency, but capturing `response` in a @MainActor isolated closure does.
            guard let delegate = SpeziAppDelegate.appDelegate else {
                return
            }

            for handler in delegate.spezi.notificationHandler {
                group.addTask { @MainActor in
                    await handler.handleNotificationAction(response)
                }
            }

            await group.waitForAll()
        }
    }
#endif

    @MainActor
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        await withTaskGroup(of: UNNotificationPresentationOptions?.self) { @MainActor group in
            // See comment in method above.
            guard let delegate = SpeziAppDelegate.appDelegate else {
                return []
            }

            for handler in delegate.spezi.notificationHandler {
                group.addTask { @Sendable @MainActor in
                    await handler.receiveIncomingNotification(notification)
                }
            }

            var hasSpecified = false

            var unionOptions: UNNotificationPresentationOptions = []
            for await options in group {
                guard let options else {
                    continue
                }
                unionOptions.formUnion(options)
                hasSpecified = true
            }

            if hasSpecified {
                return unionOptions
            } else {
                return [.badge, .badge, .list, .sound]
            }
        }
    }
}


extension SpeziAppDelegate {
    func setupNotificationDelegate() {
        guard !spezi.notificationHandler.isEmpty else {
            return
        }

        let center = UNUserNotificationCenter.current()

        let delegate = SpeziNotificationCenterDelegate()
        Self.notificationDelegate = delegate // maintain reference
        center.delegate = delegate
    }
}
