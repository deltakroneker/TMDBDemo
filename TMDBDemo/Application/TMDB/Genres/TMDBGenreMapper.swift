//
//  TMDBGenreMapper.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import Foundation

struct TMDBGenreMapper {
    static func mapGenres(data: Data, response: HTTPURLResponse) throws -> [TMDBGenreDTO] {
        if (200..<300) ~= response.statusCode {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return (try decoder.decode(TMDBGenreContainerDTO.self, from: data)).genres
        } else if response.statusCode == 401 {
            throw TMDBError.unauthorized
        } else {
            throw TMDBError.emptyErrorWithStatusCode(response.statusCode.description)
        }
    }
}
