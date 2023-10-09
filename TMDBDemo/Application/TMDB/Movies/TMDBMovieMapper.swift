//
//  MovieMapper.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

struct TMDBMovieMapper {
    static func mapMovies(data: Data, response: HTTPURLResponse) throws -> [TMDBMovieDTO] {
        if (200..<300) ~= response.statusCode {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return (try decoder.decode(TMDBMovieContainerDTO.self, from: data)).results
        } else if response.statusCode == 401 {
            throw TMDBError.unauthorized
        } else {
            throw TMDBError.emptyErrorWithStatusCode(response.statusCode.description)
        }
    }
}
