//
//  AccountModel.swift
//  Domain
//
//  Created by Andre Luis Campopiano on 25/02/22.
//

import Foundation

public struct AccountModel: Model {
    
    // MARK: - Properties
    public var id: String
    public var name: String
    public var email: String
    public var password: String
    
    // MARK: - Initialize
    public init(id: String,
                name: String,
                email: String,
                password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
