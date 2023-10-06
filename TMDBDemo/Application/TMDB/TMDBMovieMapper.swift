//
//  MovieMapper.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

struct TMDBMovieMapper {
    static func mapMovie(data: Data, response: HTTPURLResponse) throws -> [TMDBMovieDTO] {
        if (200..<300) ~= response.statusCode {
            return (try JSONDecoder().decode(TMDBMovieContainerDTO.self, from: data)).movies
        } else if response.statusCode == 401 {
            throw TMDBError.unauthorized
        } else {
            throw TMDBError.emptyErrorWithStatusCode(response.statusCode.description)
        }
    }
}
