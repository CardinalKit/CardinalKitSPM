//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


import os
import SpeziFoundation
import SwiftUI
import XCTRuntimeAssertions


/// A ``SharedRepository`` implementation that is anchored to ``SpeziAnchor``.
///
/// This represents the central ``Spezi`` storage module.
@_documentation(visibility: internal)
public typealias SpeziStorage = HeapRepository<SpeziAnchor>


private struct ImplicitlyCreatedModulesKey: DefaultProvidingKnowledgeSource {
    typealias Value = Set<ModuleReference>
    typealias Anchor = SpeziAnchor

    static let defaultValue: Value = []
}


/// Open-source framework for rapid development of modern, interoperable digital health applications.
///
/// Set up the Spezi framework in your `App` instance of your SwiftUI application using the ``SpeziAppDelegate`` and the `@ApplicationDelegateAdaptor` property wrapper.
/// Use the `View.spezi(_: SpeziAppDelegate)` view modifier to apply your Spezi configuration to the main view in your SwiftUI `Scene`:
/// ```swift
/// import Spezi
/// import SwiftUI
///
///
/// @main
/// struct ExampleApp: App {
///     @ApplicationDelegateAdaptor(SpeziAppDelegate.self) var appDelegate
///
///
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .spezi(appDelegate)
///         }
///     }
/// }
/// ```
///
/// Register your different ``Module``s (or more sophisticated ``Module``s) using the ``SpeziAppDelegate/configuration`` property.
/// ```swift
/// import Spezi
///
///
/// class TemplateAppDelegate: SpeziAppDelegate {
///     override var configuration: Configuration {
///         Configuration(standard: ExampleStandard()) {
///             // Add your `Module`s here ...
///        }
///     }
/// }
/// ```
///
/// The ``Module`` documentation provides more information about the structure of modules.
/// Refer to the ``Configuration`` documentation to learn more about the Spezi configuration.
///
/// ## Topics
///
/// ### Properties
/// - ``logger``
/// - ``launchOptions``
///
/// ### Actions
/// - ``registerRemoteNotifications``
/// - ``unregisterRemoteNotifications``
@Observable
public class Spezi {
    static let logger = Logger(subsystem: "edu.stanford.spezi", category: "Spezi")

    @TaskLocal static var moduleInitContext: (any Module)?

    let standard: any Standard
    /// A shared repository to store any ``KnowledgeSource``s restricted to the ``SpeziAnchor``.
    ///
    /// Every `Module` automatically conforms to `KnowledgeSource` and is stored within this storage object.
    @ObservationIgnored fileprivate(set) var storage: SpeziStorage

    /// Array of all SwiftUI `ViewModifiers` collected using ``_ModifierPropertyWrapper`` from the configured ``Module``s.
    var viewModifiers: [any ViewModifier]

    /// A collection of ``Spezi/Spezi`` `LifecycleHandler`s.
    @available(
        *,
         deprecated,
         message: """
             Please use the new @Application property wrapper to access delegate functionality. \
             Otherwise use the SwiftUI onReceive(_:perform:) for UI related notifications.
             """
    )


    @_spi(Spezi)
    public var lifecycleHandler: [LifecycleHandler] {
        storage.collect(allOf: LifecycleHandler.self)
    }

    var notificationTokenHandler: [NotificationTokenHandler] {
        storage.collect(allOf: NotificationTokenHandler.self)
    }

    var notificationHandler: [NotificationHandler] {
        storage.collect(allOf: NotificationHandler.self)
    }

    var modules: [any Module] {
        storage.collect(allOf: (any Module).self)
    }

    private var implicitlyCreatedModules: Set<ModuleReference> {
        get {
            storage[ImplicitlyCreatedModulesKey.self]
        }
        set {
            storage[ImplicitlyCreatedModulesKey.self] = newValue
        }
    }

    /// Access the global Spezi instance.
    ///
    /// Access the global Spezi instance using the ``Module/Application`` property wrapper inside your ``Module``.
    ///
    /// Below is a short code example on how to access the Spezi instance.
    ///
    /// ```swift
    /// class ExampleModule: Module {
    ///     @Application(\.spezi)
    ///     var spezi
    /// }
    /// ```
    public var spezi: Spezi {
        // this seems nonsensical, but is essential to support Spezi access from the @Application modifier
        self
    }


    convenience init(from configuration: Configuration, storage: consuming SpeziStorage = SpeziStorage()) {
        self.init(standard: configuration.standard, modules: configuration.modules.elements, storage: storage)
    }
    

    /// Create a new Spezi instance.
    ///
    /// - Parameters:
    ///   - standard: The standard to use.
    ///   - modules: The collection of modules to initialize.
    ///   - storage: Optional, initial storage to inject.
    @_spi(Spezi)
    public init(
        standard: any Standard,
        modules: [any Module],
        storage: consuming SpeziStorage = SpeziStorage()
    ) {
        self.standard = standard
        self.storage = consume storage
        self.viewModifiers = []

        self.loadModules([self.standard] + modules)
    }

    /// Load a new Module.
    ///
    /// Loads a new Spezi ``Module`` resolving all dependencies.
    /// - Note: Trying to load the same ``Module`` instance multiple times results in a runtime crash.
    ///
    /// - Parameter module: The new Module instance to load.
    public func loadModule(_ module: any Module) {
        loadModules([module])
    }

    private func loadModules(_ modules: [any Module]) {
        let existingModules = self.modules

        let dependencyManager = DependencyManager(modules, existing: existingModules)
        dependencyManager.resolve()

        implicitlyCreatedModules.formUnion(dependencyManager.implicitlyCreatedModules)

        for module in dependencyManager.initializedModules {
            // we pass through the whole list of modules once to collect all @Provide values
            module.collectModuleValues(into: &storage)
        }

        for module in dependencyManager.initializedModules {
            self.initModule(module)
        }


        // Newly loaded modules might have @Provide values that need to be updated in @Collect properties in existing modules.
        for existingModule in existingModules {
            // TODO: do we really want to support that?, that gets super chaotic with unload modules???
            // TODO: create an issue to have e.g. update functionality (rework that whole thing?), remove that system altogether?
            existingModule.injectModuleValues(from: storage)
        }
    }

    /// Unload a Module.
    ///
    /// Unloads a ``Module`` from the Spezi system.
    /// - Important: Unloading a ``Module`` that is still required by other modules results in a runtime crash.
    ///     However, unloading a Module that is the **optional** dependency of another Module works.
    ///
    /// Unloading a Module will recursively unload its dependencies that were not loaded explicitly.
    ///
    /// - Parameter module: The Module to unload.
    public func unloadModule(_ module: any Module) {
        guard module.isLoaded(in: self) else {
            return // module is not loaded
        }

        let dependents = retrieveDependingModules(module)
        precondition(dependents.isEmpty, "Tried to unload Module \(type(of: module)) that is still required by peer Modules: \(dependents)")

        module.clearModule(from: self)

        implicitlyCreatedModules.remove(ModuleReference(module))

        // TODO: remove @Collect values that were previously provided by this Module

        // re-injecting all dependencies ensures that the unloaded module is cleared from optional Dependencies from
        // pre-existing Modules.
        let dependencyManager = DependencyManager([], existing: modules)
        dependencyManager.resolve()


        // Check if we need to unload additional modules that were not explicitly created.
        // For example a explicitly loaded Module might have recursive @Dependency declarations that are automatically loaded.
        // Such modules are unloaded as well if they are no longer required.
        for dependencyDeclaration in module.dependencyDeclarations {
            let dependencies = dependencyDeclaration.injectedDependencies
            for dependency in dependencies {
                guard implicitlyCreatedModules.contains(ModuleReference(dependency)) else {
                    // we only recursively unload modules that have been created implicitly
                    continue
                }

                guard retrieveDependingModules(dependency).isEmpty else {
                    continue
                }

                unloadModule(dependency)
            }
        }
    }

    /// Initialize a Module.
    ///
    /// Call this method to initialize a Module, injecting necessary information into Spezi property wrappers.
    ///
    /// - Parameters:
    ///   - module: The module to initialize.
    private func initModule(_ module: any Module) {
        precondition(!module.isLoaded(in: self), "Tried to initialize Module \(type(of: module)) that was already loaded!")

        Self.$moduleInitContext.withValue(module) {
            module.inject(spezi: self)

            // supply modules values to all @Collect
            module.injectModuleValues(from: storage)

            module.configure()
            module.storeModule(into: self)

            viewModifiers.append(contentsOf: module.viewModifiers)

            // If a module is @Observable, we automatically inject it view the `ModelModifier` into the environment.
            if let observable = module as? EnvironmentAccessible {
                viewModifiers.append(observable.viewModifier)
            }
        }
    }

    /// Determine if a application property is stored as a copy in a `@Application` property wrapper.
    func createsCopy<Value>(_ keyPath: KeyPath<Spezi, Value>) -> Bool {
        keyPath == \.logger // loggers are created per Module.
    }

    private func retrieveDependingModules(_ dependency: any Module, considerOptionals: Bool = false) -> [any Module] {
        var result: [any Module] = []

        for module in modules {
            switch module.dependencyRelation(to: dependency) {
            case .dependent:
                result.append(module)
            case .optional:
                if considerOptionals {
                    result.append(module)
                }
            case .unrelated:
                continue
            }
        }

        return result
    }
}


extension Module {
    fileprivate func storeModule(into spezi: Spezi) {
        guard let value = self as? Value else {
            spezi.logger.warning("Could not store \(Self.self) in the SpeziStorage as the `Value` typealias was modified.")
            return
        }
        spezi.storage[Self.self] = value
    }

    fileprivate func isLoaded(in spezi: Spezi) -> Bool {
        spezi.storage[Self.self] != nil
    }

    fileprivate func clearModule(from spezi: Spezi) {
        spezi.storage[Self.self] = nil
    }
}
