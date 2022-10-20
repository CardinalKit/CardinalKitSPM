//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import os
import SwiftUI


extension AnyCardinalKit {
    /// A collection of ``CardinalKit/CardinalKit`` `LifecycleHandler`s.
    private var lifecycleHandler: [LifecycleHandler] {
        get async {
            await storage.get(allThatConformTo: LifecycleHandler.self)
        }
    }
    
    
    // MARK: LifecycleHandler Functions
    func willFinishLaunchingWithOptions(
        _ application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]
    ) {
        Task(priority: .userInitiated) {
            await lifecycleHandler.willFinishLaunchingWithOptions(application, launchOptions: launchOptions)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Task(priority: .userInitiated) {
            await lifecycleHandler.applicationWillTerminate(application)
        }
    }
}
