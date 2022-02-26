//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Domain
import Foundation

public final class RemoteAddAccount {
    
    // MARK: - Properties
    private let url: URL
    private let httpClient: HttpPostClient
    
    // MARK: - Initialize
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    // MARK: - Public Methods
    public func add(addAccountModel: AddAccountModel) {
        httpClient.post(to: url, with: addAccountModel.toData())
    }
}
