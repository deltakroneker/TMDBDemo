//
//  TMDBRequestProvider.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

typealias Page = Int

enum TMDBRequestProvider {
    case topRated(p: Page)
    
    private var baseURL: String { "https://api.themoviedb.org/3" }
    
    var path: String {
        switch self {
        case .topRated(let p):
            return baseURL + "/movie/top_rated?language=en-US&page=\(p)"
        }
    }
    
    var makeRequest: URLRequest {
        guard let url = URL(string: path) else {
            preconditionFailure("URL is not valid")
        }
        return URLRequest(url: url)
    }
}
