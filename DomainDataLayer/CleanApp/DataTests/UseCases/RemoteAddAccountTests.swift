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
    
    func testAddShouldNotCompleteIfSutHasBeenDeallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeUrl, httpClient: httpClientSpy)
        var result: Result<AccountModel,DomainError>?
        sut?.add(addAccountModel: makeAddAccountModel) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
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
    
    // MARK: - Factory Helper Methods
    func makeSut(url: URL = URL(string: "http://any.url.com")!,
                 file: StaticString = #file,
                 line: UInt = #line) -> (sut: RemoteAddAccount, httpClient: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAddAccount,
                completeWith expectedResult: Result<AccountModel, DomainError>,
                when action: () -> Void,
                file: StaticString = #file,
                line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel) { receivedResult in
            switch (expectedResult, receivedResult) {
                case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
                case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(receivedResult) received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
