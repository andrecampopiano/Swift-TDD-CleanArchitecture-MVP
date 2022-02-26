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

protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping AccountModelCompletion)
}

// MARK: - Structs

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}

