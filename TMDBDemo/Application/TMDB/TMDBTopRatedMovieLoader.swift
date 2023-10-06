//
//  TMDBTopRatedMovieLoader.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine

class TMDBRemoteTopRatedMovieLoader: PaginatedMovieLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load(page: Int) -> AnyPublisher<[Movie], Error> {
        return self.client.publisher(request: TMDBRequestProvider.topRated(p: page).makeRequest)
            .tryMap(TMDBMovieMapper.mapMovie)
            .map({ dtos in
                dtos.map { dto in
                    Movie(id: dto.id,
                          name: dto.title,
                          genres: dto.genreIds.map({ Genre(id: $0, name: String($0)) }), // TODO: Implement proper resolving of genres
                          poster: dto.posterPath,
                          rating: dto.voteAverage)
                }
            })
            .eraseToAnyPublisher()
    }
}
