//
//  URLSessionHTTPClient.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine

extension URLSession: HTTPClient {
    struct InvalidHTTPResponseError: Error {}
    
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        return dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw InvalidHTTPResponseError()
                }
                return (result.data, httpResponse)
            }
            .eraseToAnyPublisher()
    }
}
