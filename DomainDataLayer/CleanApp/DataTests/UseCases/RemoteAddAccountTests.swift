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
        let url = makeUrl
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func testAddShouldCompleteWithErrorIfClientCompletesWithError() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func testAddShouldCompleteWithAccountIfClientCompletesWithValidData() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel
        expect(sut, completeWith: .success(account)) {
            httpClientSpy.completedWithData(account.toData()!)
        }
    }
    
    func testAddShouldCompleteWithErrorIfClientCompletesWithInvalidData() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completedWithData(makeInvalidData)
        }
    }
    
}

extension RemoteAddAccountTests {
    
    // MARK: - Factory Helper Properties
    var makeAddAccountModel: AddAccountModel {
        return AddAccountModel(name: "any_name",
                               email: "any_email@gmail.com",
                               password: "any_password",
                               passwordConfirmation: "any_password")
    }
    
    var makeAccountModel: AccountModel {
        return AccountModel(id: "any_id",
                            name: "any_name",
                            email: "any_email@gmail.com",
                            password: "any_password")
    }
    
    var makeInvalidData: Data {
        return Data("invalid_data".utf8)
    }
    
    var makeUrl: URL {
        return URL(string: "http://any.url.com")!
    }
    
    // MARK: - Factory Helper Methods
    func makeSut(url: URL = URL(string: "http://any.url.com")!) -> (sut: RemoteAddAccount, httpClient: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount)
            default: XCTFail("Expected \(receivedResult) received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    // MARK: - Mock Class HttpClient
    class HttpClientSpy: HttpPostClient {
      
        // MARK: - Properties
        var urls = [URL]()
        var data: Data?
        var completion: HttpPostClientCompletion?
        
        // MARK: - Public Methods
        func post(to url: URL, with data: Data?, completion: @escaping HttpPostClientCompletion) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
        
        func completedWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}
