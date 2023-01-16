//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


public actor Firestore<ComponentStandard: Standard>: Module, DataStorageProvider {
    public typealias FirestoreAdapter = any FirestoreElementAdapter<ComponentStandard.BaseType, ComponentStandard.RemovalContext>


    private let settings: FirestoreSettings
    private let adapter: FirestoreAdapter


    public init(settings: FirestoreSettings = FirestoreSettings())
        where ComponentStandard.BaseType: FirestoreElement, ComponentStandard.RemovalContext: FirestoreRemovalContext {
        self.adapter = DefaultFirestoreElementAdapter()
        self.settings = settings
    }
    
    public init(adapter: FirestoreAdapter, settings: FirestoreSettings = FirestoreSettings()) {
        self.adapter = adapter
        self.settings = settings
    }
    
    
    nonisolated public func willFinishLaunchingWithOptions(
        _ application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]
    ) {
        FirebaseApp.configure()
        
        #warning("Replace with actual settings .... Using the Firebase Emulator for now.")
        FirebaseFirestore.Firestore.firestore().settings = .emulator
        
        _ = FirebaseFirestore.Firestore.firestore()
    }
    
    public func process(_ element: DataChange<ComponentStandard.BaseType, ComponentStandard.RemovalContext>) async throws {
        switch element {
        case let .addition(element):
            let firebaseElement = await adapter.transform(element: element)
            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                do {
                    let firestore = FirebaseFirestore.Firestore.firestore()
                    try firestore
                        .collection(firebaseElement.collectionPath)
                        .document(firebaseElement.id)
                        .setData(from: firebaseElement, merge: false) { error in
                            if let error {
                                continuation.resume(throwing: error)
                            } else {
                                continuation.resume()
                            }
                        }
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        case let .removal(removalContext):
            let firebaseRemovalContext = await adapter.transform(removalContext: removalContext)
            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                let firestore = FirebaseFirestore.Firestore.firestore()
                firestore
                    .collection(firebaseRemovalContext.collectionPath)
                    .document(firebaseRemovalContext.id)
                    .delete { error in
                        if let error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume()
                        }
                    }
            }
        }
    }
}