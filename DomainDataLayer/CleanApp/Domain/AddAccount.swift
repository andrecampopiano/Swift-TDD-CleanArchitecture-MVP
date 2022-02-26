//
//  AddAccount.swift
//  Domain
//
//  Created by Andre Luis Campopiano on 25/02/22.
//

import Foundation

// MARK: - Typealias

typealias AccountModelCompletion = ((Result<AccountModel, Error>) -> Void)

// MARK: - Protocol

public protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping AccountModelCompletion)
}

// MARK: - Structs

public struct AddAccountModel {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
}

