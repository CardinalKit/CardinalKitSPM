//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A ``Component`` defines a software subsystem that can be configured as part of the ``SpeziAppDelegate/configuration``.
///
/// The ``Component/ComponentStandard`` defines what Standard the component supports.
/// The ``Component/configure()-m7ic`` method is called on the initialization of Spezi.
///
///
/// **The Component Standard**
///
/// A ``Component`` can support any generic standard or add additional constraints using an optional where clause:
/// ```swift
/// class ExampleComponent<ComponentStandard: Standard>: Component where ComponentStandard: /* ... */ {
///     /*... */
/// }
/// ```
///
/// ``Component``s can also specify support for only one specific ``Standard`` using a `typealias` definition:
/// ```swift
/// class ExampleFHIRComponent: Component {
///     typealias ComponentStandard = FHIR
/// }
/// ```
///
///
/// **Dependencies**
///
/// ``Component``s can define dependencies between each other using the @``Component/Dependency`` property wrapper.
/// ```swift
/// class ExampleComponent<ComponentStandard: Standard>: Component {
///     @Dependency var exampleComponentDependency = ExampleComponentDependency()
/// }
/// ```
///
///
/// **Additional Capabilities**
///
/// Components can also conform to different additional protocols to provide additional access to Spezi features.
/// - ``LifecycleHandler``: Delegate methods are related to the  `UIApplication` and ``Spezi/Spezi`` lifecycle.
/// - ``ObservableObjectProvider``: A ``Component`` can conform to ``ObservableObjectProvider`` to inject `ObservableObject`s in the SwiftUI view hierarchy.
///
/// All these protocols are combined in the ``Module`` protocol, making it an easy one-stop solution to support all these different functionalities and build a capable Spezi module.
public protocol Component: AnyObject, TypedCollectionKey {
    /// The ``Component/configure()-m7ic`` method is called on the initialization of the Spezi instance to perform a lightweight configuration of the component.
    ///
    /// It is advised that longer setup tasks are done in an asynchronous task and started during the call of the configure method.
    func configure()
}


extension Component {
    // A documentation for this methodd exists in the `Component` type which SwiftLint doesn't recognize.
    // swiftlint:disable:next missing_docs
    public func configure() {}
}