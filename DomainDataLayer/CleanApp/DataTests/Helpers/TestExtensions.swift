//
//  TestExtensions.swift
//  DataTests
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func checkMemoryLeak(for instance: AnyObject,
                         file: StaticString = #file,
                         line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
