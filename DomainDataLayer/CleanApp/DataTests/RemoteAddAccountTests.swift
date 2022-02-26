//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Andre Luis Campopiano on 25/02/22.
//

import XCTest

class RemoteAddAccount {
    
    // MARK: - Properties
    private let url: URL
    private let httpClient: HttpClient
    
    // MARK: - Initialize
    init(url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    // MARK: - Public Methods
    func add() {
        httpClient.post(url: url)
    }
}

protocol HttpClient {
    func post(url: URL)
}

class RemoteAddAccountTests: XCTestCase {
    
    // MARK: - Tests
    func test_() {
        let url = URL(string: "http://any.url.com")
        let httpClientSpy = HttpClientSpy()
        guard let url = url else { return }
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    // MARK: - Mock Class HttpClient
    class HttpClientSpy: HttpClient {
        
        // MARK: - Properties
        var url: URL?
        
        // MARK: - Public Methods
        func post(url: URL) {
            self.url = url
        }
    }
}
