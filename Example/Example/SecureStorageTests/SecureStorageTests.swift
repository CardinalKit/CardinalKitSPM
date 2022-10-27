//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SecureStorage
import Security
import Foundation


final class SecureStorageTests {
    func testCredentials() throws {
        let secureStorage = SecureStorage<UITestsAppStandard>()
        
        var serverCredentials = Credentials(username: "@PSchmiedmayer", password: "CardinalKitInventor")
        try secureStorage.store(credentials: serverCredentials)
        try secureStorage.store(credentials: serverCredentials) // Overwrite existing credentials.
        
        let retrievedCredentials = try XCTUnwrap(secureStorage.retrieveCredentials("@PSchmiedmayer"))
        try XCTAssertEqual(serverCredentials, retrievedCredentials)
        
        
        serverCredentials = Credentials(username: "@CardinalKit", password: "Paul")
        try secureStorage.updateCredentials("@PSchmiedmayer", newCredentials: serverCredentials)
        
        let retrievedUpdatedCredentials = try XCTUnwrap(secureStorage.retrieveCredentials("@CardinalKit"))
        try XCTAssertEqual(serverCredentials, retrievedUpdatedCredentials)
        
        
        try secureStorage.deleteCredentials("@CardinalKit")
        try XCTAssertNil(try secureStorage.retrieveCredentials("@CardinalKit"))
    }
    
    func testInternetCredentials() throws {
        let secureStorage = SecureStorage<UITestsAppStandard>()
        
        var serverCredentials = Credentials(username: "@PSchmiedmayer", password: "CardinalKitInventor")
        try secureStorage.store(credentials: serverCredentials, server: "twitter.com")
        try secureStorage.store(credentials: serverCredentials, server: "twitter.com") // Overwrite existing credentials.
        
        let retrievedCredentials = try XCTUnwrap(secureStorage.retrieveCredentials("@PSchmiedmayer", server: "twitter.com"))
        try XCTAssertEqual(serverCredentials, retrievedCredentials)
        
        
        serverCredentials = Credentials(username: "@CardinalKit", password: "Paul")
        try secureStorage.updateCredentials("@PSchmiedmayer", server: "twitter.com", newCredentials: serverCredentials, newServer: "stanford.edu")
        
        let retrievedUpdatedCredentials = try XCTUnwrap(secureStorage.retrieveCredentials("@CardinalKit", server: "stanford.edu"))
        try XCTAssertEqual(serverCredentials, retrievedUpdatedCredentials)
        
        
        try secureStorage.deleteCredentials("@CardinalKit", server: "stanford.edu")
        try XCTAssertNil(try secureStorage.retrieveCredentials("@CardinalKit", server: "stanford.edu"))
    }
    
    func testKeys() throws {
        let secureStorage = SecureStorage<UITestsAppStandard>()
        
        try secureStorage.deleteKeys(forTag: "MyKey")
        try XCTAssertNil(try secureStorage.retrievePublicKey(forTag: "MyKey"))
        
        try secureStorage.createKey("MyKey", userPresence: false)
        try secureStorage.createKey("MyKey", userPresence: false)
        
        let privateKey = try XCTUnwrap(secureStorage.retrievePrivateKey(forTag: "MyKey"))
        let publicKey = try XCTUnwrap(secureStorage.retrievePublicKey(forTag: "MyKey"))
        
        let algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorX963SHA256AESGCM
        
        guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, algorithm) else {
            throw XCTestFailure()
        }
        
        let plainText = Data("CardinalKit & Paul Schmiedmayer".utf8)
        
        var encryptError: Unmanaged<CFError>?
        guard let cipherText = SecKeyCreateEncryptedData(publicKey, algorithm, plainText as CFData, &encryptError) as Data? else {
            throw encryptError!.takeRetainedValue() as Error
        }
        
        guard SecKeyIsAlgorithmSupported(privateKey, .decrypt, algorithm) else {
            throw XCTestFailure()
        }
        
        var decryptError: Unmanaged<CFError>?
        guard let clearText = SecKeyCreateDecryptedData(privateKey, algorithm, cipherText as CFData, &decryptError) as Data? else {
            throw decryptError!.takeRetainedValue() as Error
        }
        
        try XCTAssertEqual(plainText, clearText)
        print("Decryped: \(String(decoding: clearText, as: UTF8.self))")
        
        try secureStorage.deleteKeys(forTag: "MyKey")
        try XCTAssertNil(try secureStorage.retrievePublicKey(forTag: "MyKey"))
    }
}
