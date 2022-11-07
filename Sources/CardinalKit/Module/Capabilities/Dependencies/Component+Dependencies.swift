//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


extension Component {
    /// Defines a dependency to an other ``Component``.
    ///
    /// A ``Component`` can define the dependencies using the ``@Dependency`` property wrapper:
    /// ```
    /// class ExampleComponent<ComponentStandard: Standard>: Component {
    ///     @Dependency var exampleComponentDependency = ExampleComponentDependency()
    /// }
    /// ```
    ///
    /// Some component do not need a default value assigned to the property if they provide a default configuration and conform to ``DefaultInitializable``.
    /// ```
    /// class ExampleComponent<ComponentStandard: Standard>: Component {
    ///     @Dependency var exampleComponentDependency: ExampleComponentDependency
    /// }
    /// ```
    ///
    /// You can access the wrapped value of the ``Dependency`` after the ``Component`` is configured using ``Component/configure()``,
    /// e.g. in the ``LifecycleHandler/willFinishLaunchingWithOptions(_:launchOptions:)`` function.
    public typealias Dependency<C: Component> = _DependencyPropertyWrapper<C, ComponentStandard> where C.ComponentStandard == ComponentStandard
    
    
    // public typealias DynamicDependencies = _DynamicDependenciesPropertyWrapper<ComponentStandard>
}
