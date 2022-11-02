//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

@testable import CardinalKit
@testable import LocalStorage
import XCTest


final class LocalStorageTests: XCTestCase {
    struct LocalStorageTestStandard: Standard {}
    
    struct Letter: Codable, Equatable {
        let greeting: String
    }
    
    class LocalStorageTestsAppDelegate: CardinalKitAppDelegate {
        override var configuration: Configuration {
            Configuration(standard: LocalStorageTestStandard()) {
                LocalStorage()
            }
        }
    }
    
    
    func testLocalStorage() async throws {
        let cardinalKit = await LocalStorageTestsAppDelegate().cardinalKit
        let localStorage = try XCTUnwrap(cardinalKit.typedCollection[LocalStorage<LocalStorageTestStandard>.self])
        
        let letter = Letter(greeting: "Hello Paul 👋\(String(repeating: "🚀", count: Int.random(in: 0...10)))")
        try await localStorage.store(letter, settings: .unencryped())
        let storedLetter: Letter = try await localStorage.read(settings: .unencryped())
        
        XCTAssertEqual(letter, storedLetter)
        
        try await localStorage.delete(Letter.self)
        try await localStorage.delete(storageKey: "Letter")
    }
}