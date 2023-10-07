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
        if #available(iOS 16.0, *) {
            authenticatedRequest.url?.append(queryItems: [URLQueryItem(name: "api_key", value: apiKey)])
        } else {
            authenticatedRequest.url?.appendQueryItem(name: "api_key", value: apiKey)
        }
        return httpClient.publisher(request: authenticatedRequest)
    }
}

extension URL {
    mutating func appendQueryItem(name: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
}
