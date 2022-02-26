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
    private let httpClient: HttpPostClient
    
    // MARK: - Initialize
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    // MARK: - Public Methods
    func add() {
        httpClient.post(url: url)
    }
}

// MARK: - HttpPostClient
protocol HttpPostClient {
    func post(url: URL)
}

// MARK: - HttpGetClient
protocol HttpGetClient {
    func get(url: URL)
}

class RemoteAddAccountTests: XCTestCase {
    
    // MARK: - Tests
    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = URL(string: "http://any.url.com")
        let httpClientSpy = HttpClientSpy()
        guard let url = url else { return }
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    // MARK: - Mock Class HttpClient
    class HttpClientSpy: HttpPostClient, HttpGetClient {
      
        // MARK: - Properties
        var url: URL?
        
        // MARK: - Public Methods
        func post(url: URL) {
            self.url = url
        }
        
        func get(url: URL) {
            
        }
    }
}
