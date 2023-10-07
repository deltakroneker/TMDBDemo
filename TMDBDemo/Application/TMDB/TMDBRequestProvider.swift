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
    case genres
    
    private static let baseURL = "https://api.themoviedb.org/3"
    private static let imageBaseURL = "https://image.tmdb.org/t/p"
    
    var path: String {
        switch self {
        case .topRated(let p):
            return TMDBRequestProvider.baseURL + "/movie/top_rated?language=en-US&page=\(p)"
        case .genres:
            return TMDBRequestProvider.baseURL + "/genre/movie/list"
        }
    }
    
    var makeRequest: URLRequest {
        guard let url = URL(string: path) else {
            preconditionFailure("URL is not valid")
        }
        return URLRequest(url: url)
    }
    
    static func posterUrl(for posterPath: String, customWidth: Int) -> URL? {
        return URL(string: "\(TMDBRequestProvider.imageBaseURL)/w\(customWidth)\(posterPath)")
    }
}
