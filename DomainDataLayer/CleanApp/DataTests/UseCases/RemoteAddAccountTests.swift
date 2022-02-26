//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Andre Luis Campopiano on 25/02/22.
//

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {
    
    // MARK: - Tests
    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = URL(string: "http://any.url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
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
        var urls = [URL]()
        var data: Data?
        
        // MARK: - Public Methods
        func post(to url: URL, with data: Data?) {
            self.urls.append(url)
            self.data = data
        }
    }
}
