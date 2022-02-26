//
//  HttpPostClient.swift
//  Data
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Foundation

public typealias HttpPostClientCompletion = ((Result<Data, HttpError>) -> Void)

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping HttpPostClientCompletion)
}
