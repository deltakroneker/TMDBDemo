//
//  TMDBGenreDTO.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import Foundation

struct TMDBGenreContainerDTO: Codable {
    let genres: [TMDBGenreDTO]
}

struct TMDBGenreDTO: Codable {
    let id: Int
    let name: String
}
