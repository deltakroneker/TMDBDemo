//
//  TMDBRequestProvider.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

typealias Query = String
typealias Page = Int

enum TMDBRequestProvider {
    case topRated(p: Page)
    case genres
    case search(q: Query, p: Page)
    
    private static let baseURL = "https://api.themoviedb.org/3"
    private static let imageBaseURL = "https://image.tmdb.org/t/p"
    
    var path: String {
        switch self {
        case .topRated(let p):
            return TMDBRequestProvider.baseURL + "/movie/top_rated?language=en-US&page=\(p)"
        case .genres:
            return TMDBRequestProvider.baseURL + "/genre/movie/list"
        case .search(let q, let p):
            let urlEncodedQuery = q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return TMDBRequestProvider.baseURL + "/search/movie?query=\(urlEncodedQuery)&include_adult=false&language=en-US&page=\(p)"
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
