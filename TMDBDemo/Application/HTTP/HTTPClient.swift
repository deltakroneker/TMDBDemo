//
//  HTTPClient.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine

protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}
