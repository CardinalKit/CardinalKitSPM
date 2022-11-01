//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


protocol AnyDependencyPropertyWrapper: AnyObject {
    associatedtype AnyDependencyPropertyWrapperStandard: Standard
    
    
    func gatherDependency(dependencyManager: _DependencyManager)
    func inject(dependencyManager: _DependencyManager)
}