//
//  AuthenticatedHTTPClientDecorator.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine

class AuthenticatedHTTPClientDecorator: HTTPClient {
    let httpClient: HTTPClient
    let apiKey: String
    
    init(httpClient: HTTPClient, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        var authenticatedRequest = request
        authenticatedRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return httpClient.publisher(request: authenticatedRequest)
    }
}
