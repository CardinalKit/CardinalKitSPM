//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


/// The `CardinalKitAppDelegate` is used to configure the CardinalKit-based application using the ``CardinalKitAppDelegate/configuration`` property.
///
/// Set up the CardinalKit framework in your `App` instance of your SwiftUI applicaton using the ``CardinalKitAppDelegate`` and the `@UIApplicationDelegateAdaptor` property wrapper.
/// Use the ``SwiftUI/View/.cardinalKit(_: CardinalKitAppDelegate)`` view modifier to apply your CardinalKit configuration to the main view in your SwiftUI `Scene`:
/// ```
/// import CardinalKit
/// import SwiftUI
///
///
/// @main
/// struct ExampleApp: App {
///     @UIApplicationDelegateAdaptor(CardinalKitAppDelegate.self) var appDelegate
///
///
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .cardinalKit(appDelegate)
///         }
///     }
/// }
/// ```
open class CardinalKitAppDelegate: NSObject, UIApplicationDelegate {
    private struct AnyStandard: Standard {}
    
    
    private(set) lazy var cardinalKit: AnyCardinalKit = configuration.anyCardinalKit
    
    
    open var configuration: Configuration {
        Configuration(standard: AnyStandard()) { }
    }
    
    
    open func application(
        _ application: UIApplication,
        // The usage of an optional collection is impossible to avoid as the function signature is defined by the `UIApplicationDelegate`
        // swiftlint:disable:next discouraged_optional_collection
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        cardinalKit.willFinishLaunchingWithOptions(application, launchOptions: launchOptions ?? [:])
        return true
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        cardinalKit.applicationWillTerminate(application)
    }
}
