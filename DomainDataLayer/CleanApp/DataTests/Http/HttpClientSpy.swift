//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Andre Luis Campopiano on 26/02/22.
//

import Data
import Foundation

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
