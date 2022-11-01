//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


extension _AnyComponent {
    var dependencies: [any AnyDependencyPropertyWrapper] {
        let mirror = Mirror(reflecting: self)
        var dependencies: [any AnyDependencyPropertyWrapper] = []
        
        for child in mirror.children {
            guard let dependencyPropertyWrapper = child.value as? any AnyDependencyPropertyWrapper else {
                continue
            }
            dependencies.append(dependencyPropertyWrapper)
        }
        
        return dependencies
    }
}


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
    /// You can access the wrapped value of the ``Dependency`` after the ``Component`` is configured using ``Component/configure(cardinalKit:)-38pyu``,
    /// e.g. in the ``LifecycleHandler/willFinishLaunchingWithOptions(_:launchOptions:)-lsab`` function.
    public typealias Dependency<C: Component> = _DependencyPropertyWrapper<C, ComponentStandard> where C.ComponentStandard == ComponentStandard
}