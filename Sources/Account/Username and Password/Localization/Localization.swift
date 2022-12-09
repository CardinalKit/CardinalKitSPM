//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


public struct Localization: Codable {
    public struct Field: Codable {
        public let title: String
        public let placeholder: String
    }
    
    
    public static let `default` = Localization(
        login: Login.default,
        signUp: SignUp.default
    )
    
    
    public let login: Login
    public let signUp: SignUp
    
    
    init(
        login: Login = Localization.default.login,
        signUp: SignUp = Localization.default.signUp
    ) {
        self.login = login
        self.signUp = signUp
    }
}
