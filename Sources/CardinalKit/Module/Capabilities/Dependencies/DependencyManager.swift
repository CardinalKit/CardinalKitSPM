//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import XCTRuntimeAssertions


/// A ``DependencyManager`` in CardinalKit is used to gather information about components with dependencies.
public class _DependencyManager { // swiftlint:disable:this type_name
    // We want the _DependencyManager type to be hidden from autocompletion and document generation.
    // Therefore, we use the `_` prefix.
    /// Collection of sorted components after resolving all dependencies.
    var sortedComponents: [_AnyComponent]
    /// Collection of all omponents with dependencies that are not yet processed.
    private var componentsWithDependencies: [_AnyComponent]
    /// Collection used to keep track of components with dependencies in the recursive search.
    private var recursiveSearch: [_AnyComponent] = []
    
    
    /// A ``DependencyManager`` in CardinalKit is used to gather information about components with dependencies.
    /// - Parameter components: The components that should be resolved.
    init(_ components: [_AnyComponent]) {
        sortedComponents = components.filter { $0.dependencies.isEmpty }
        componentsWithDependencies = components.filter { !$0.dependencies.isEmpty }
        
        // Start the dependency resolution on the first component.
        if let nextComponent = componentsWithDependencies.first {
            push(nextComponent)
        }
        
        for sortedComponent in sortedComponents {
            for dependency in sortedComponent.dependencies {
                dependency.inject(dependencyManager: self)
            }
        }
    }
    
    
    /// Injects a dependency into a `_DependencyPropertyWrapper` that is resolved in the `sortedComponents`.
    /// - Parameters:
    ///   - dependencyType: The type of the dependency that should be injected.
    ///   - dependencyPropertyWrapper: `_DependencyPropertyWrapper` that the dependency should be injected into.
    func inject<C: Component, S: Standard>(
        _ dependencyType: C.Type,
        into dependencyPropertyWrapper: _DependencyPropertyWrapper<C, S>
    ) where C.ComponentStandard == S {
        guard let foundInSortedComponents = sortedComponents.first(where: { type(of: $0) == C.self }) as? C else {
            preconditionFailure("Could not find the injectable component in the `sortedComponents`.")
        }
        
        dependencyPropertyWrapper.dependency = foundInSortedComponents
    }
    
    /// Communicate a requirement to a `_DependencyManager`
    /// - Parameters:
    ///   - dependencyType: The type of the dependency that should be resolved.
    ///   - defaultValue: A default instance of the dependency that is used when the `dependencyType` is not present in the `sortedComponents` or `componentsWithDependencies`.
    func require<T: Component>(_ dependencyType: T.Type, defaultValue: @autoclosure () -> (T)) {
        // 1. Return if thedepending component is found in the `sortedComponents` collection.
        if sortedComponents.contains(where: { type(of: $0) == T.self }) {
            return
        }
        
        // 2. Search for the required component is found in the `dependingComponents` collection.
        // If not, use the default value calling the `defaultValue` autoclosure.
        guard let foundInComponentsWithDependencies = componentsWithDependencies.first(where: { type(of: $0) == T.self }) else {
            let newComponent = defaultValue()
            
            guard !newComponent.dependencies.isEmpty else {
                sortedComponents.append(newComponent)
                return
            }
            
            componentsWithDependencies.insert(newComponent, at: 0)
            push(newComponent)
            
            return
        }
        
        // Detect circles in the `recursiveSearch` collection.
        guard !recursiveSearch.contains(where: { type(of: $0) == T.self }) else {
            let dependencyChain = recursiveSearch
                .map { String(describing: type(of: $0)) }
                .joined(separator: ", ")
            
            // The last element must exist as we entered the statement using a successful `contains` statement.
            // There is not chance to recover here: If there is a crash here, we would fail in the precondition statement in the next line anyways
            let lastElement = recursiveSearch.last! // swiftlint:disable:this force_unwrapping
            preconditionFailure(
                """
                The `DependencyManager` has detected a depenency cycle of your CardinalKit components.
                The current dependency chain is: \(dependencyChain). The \(String(describing: type(of: lastElement))) required a type already present in the dependency chain.
                
                Please ensure that the components you use or develop can not trigger a dependency cycle.
                """
            )
        }
        
        // If there is no cycle, resolved the dependencies of the component found in the `dependingComponents`.
        push(foundInComponentsWithDependencies)
    }
    
    private func resolvedAllDependencies(_ dependingComponent: _AnyComponent) {
        guard !recursiveSearch.isEmpty else {
            preconditionFailure("Internal logic error in the `DependencyManager`")
        }
        let component = recursiveSearch.removeLast()
        
        guard component === dependingComponent else {
            preconditionFailure("Internal logic error in the `DependencyManager`")
        }
        
        
        let dependingComponentsCount = componentsWithDependencies.count
        componentsWithDependencies.removeAll(where: { $0 === dependingComponent })
        precondition(
            dependingComponentsCount - 1 == componentsWithDependencies.count,
            "Unexpected reduction of components. Esure that all your components conform to the same `Standard`"
        )
        
        sortedComponents.append(dependingComponent)
        
        // Call the dependency resolution mechanism on the next element in the `dependingComponents` if we are not in a recursive serach.
        if recursiveSearch.isEmpty, let nextComponent = componentsWithDependencies.first {
            push(nextComponent)
        }
    }
    
    
    private func push(_ component: _AnyComponent) {
        recursiveSearch.append(component)
        for dependency in component.dependencies {
            dependency.gatherDependency(dependencyManager: self)
        }
        resolvedAllDependencies(component)
    }
}