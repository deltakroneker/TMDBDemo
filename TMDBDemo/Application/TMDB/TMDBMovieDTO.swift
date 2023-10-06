//
//  TMDBMovieDTO.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

struct TMDBMovieContainerDTO: Codable {
    let page: Int
    let movies: [TMDBMovieDTO]
    let totalPages: Int
    let totalResults: Int
}

struct TMDBMovieDTO: Codable {
    let id: Int
    let title: String
    let genreIds: [Int]
    let posterPath: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
