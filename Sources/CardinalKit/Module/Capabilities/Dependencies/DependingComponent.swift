//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


#warning("TODO: Make DependingComponent's passing a computed property with a result builder!")
/// <#Description#>
public protocol DependingComponent: Component, AnyObject {
    @DependencyBuilder<ComponentStandard>
    var dependencies: [any Dependency] { get }
}


extension DependingComponent {
    var dependencies: [any Dependency] { [] }
}
