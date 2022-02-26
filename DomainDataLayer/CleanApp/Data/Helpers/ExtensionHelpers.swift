//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}