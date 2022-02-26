//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Andre Luis Campopiano on 25/02/22.
//

import XCTest
import Domain

class RemoteAddAccount {
    
    // MARK: - Properties
    private let url: URL
    private let httpClient: HttpPostClient
    
    // MARK: - Initialize
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    // MARK: - Public Methods
    func add(addAccountModel: AddAccountModel) {
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }
}

// MARK: - HttpPostClient
protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

class RemoteAddAccountTests: XCTestCase {
    
    // MARK: - Tests
    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = URL(string: "http://any.url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        let data = try? JSONEncoder().encode(addAccountModel)
        XCTAssertEqual(httpClientSpy.data, data)
    }
    
}

extension RemoteAddAccountTests {
    
    // MARK: - Factory Helper Methods
    func makeSut(url: URL = URL(string: "http://any.url.com")!) -> (sut: RemoteAddAccount, httpClient: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any_name",
                               email: "any_email@gmail.com",
                               password: "any_password",
                               passwordConfirmation: "any_password")
    }
    
    // MARK: - Mock Class HttpClient
    class HttpClientSpy: HttpPostClient {
      
        // MARK: - Properties
        var url: URL?
        var data: Data?
        
        // MARK: - Public Methods
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
