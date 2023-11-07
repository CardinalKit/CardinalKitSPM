# Module Dependency

Define dependence of Modules, establishing an order of initialization.

## Overview

``Module``s can define dependencies using the @``Module/Dependency`` property wrapper.

This establishes a strict order in which the ``Module/configure()-5pa83`` methods of each ``Module`` are called,
to ensure functionality of a dependency is available at configuration.

> Note: Declaring a cyclic dependency will result in a runtime error. 

```swift
class ExampleModule: Module {
    @Dependency var exampleModuleDependency = ExampleModuleDependency()
}
```

> Note: When the number of dependencies is dynamic, you might want to look at the ``Module/DynamicDependencies`` property wrapper.

### Default Initialization of Dependencies

By default, `Module`s are initialized with the options passed to the `Module`'s initialization within the ``SpeziAppDelegate/configuration``
section.
If you declare a dependency to a `Module` that is not configured by the users (e.g., some underlying configuration `Module`s might not event be
publicly accessible), is initialized with the instance that was passed to the ``Module/Dependency`` property wrapper.

- Note: `Module`s can easily provide a default configuration by adopting the ``DefaultInitializable`` protocol.  

## Topics

### Declaring Dependencies

- ``Module/Dependency``
- ``Module/DynamicDependencies``

### Managing Dependencies

- ``DefaultInitializable``
- ``ModuleDependency``
- ``DependencyManager``
- ``DependencyDescriptor``