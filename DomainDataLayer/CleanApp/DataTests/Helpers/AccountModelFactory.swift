//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Domain
import Foundation

var makeAccountModel: AccountModel {
    return AccountModel(id: "any_id",
                        name: "any_name",
                        email: "any_email@gmail.com",
                        password: "any_password")
}
