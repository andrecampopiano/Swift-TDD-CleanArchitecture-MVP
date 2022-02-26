//
//  TestFactorys.swift
//  DataTests
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Foundation
import XCTest

extension XCTestCase {
    
    // MARK: - Properties Factorys
    
    var makeInvalidData: Data {
        return Data("invalid_data".utf8)
    }
    
    var makeValidData: Data {
        return Data("{\"name\":\"Andre Luis\"}".utf8)
    }
    
    var makeUrl: URL {
        return URL(string: "http://any.url.com")!
    }
}
