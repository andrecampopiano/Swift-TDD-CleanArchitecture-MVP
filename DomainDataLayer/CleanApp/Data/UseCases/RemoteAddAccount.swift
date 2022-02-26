//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Domain
import Foundation

public final class RemoteAddAccount: AddAccount {
  
    // MARK: - Properties
    private let url: URL
    private let httpClient: HttpPostClient
    
    // MARK: - Initialize
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    // MARK: - Public Methods
    public func add(addAccountModel: AddAccountModel, completion: @escaping AccountModelCompletion) {
        httpClient.post(to: url, with: addAccountModel.toData()) { result in
            switch result {
                case .success(let data):
                    guard let model: AccountModel = data.toModel() else { return completion(.failure(.unexpected)) }
                    completion(.success(model))
                case .failure: completion(.failure(.unexpected))
            }
           
        }
    }
}
