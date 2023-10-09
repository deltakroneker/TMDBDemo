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
    let genresService: GenresService
    
    init(client: HTTPClient, genresService: GenresService) {
        self.client = client
        self.genresService = genresService
    }
    
    func load(page: Int) -> AnyPublisher<[Movie], Error> {
        return self.client.publisher(request: TMDBRequestProvider.topRated(p: page).makeRequest)
            .tryMap(TMDBMovieMapper.mapMovies)
            .map({ dtos in
                dtos.map { dto in
                    Movie(id: dto.id,
                          name: dto.title,
                          genres: dto.genreIds.map({ Genre(id: $0, name: self.genresService.genreTitle(for: $0)) }),
                          poster: dto.posterPath ?? "",
                          rating: dto.voteAverage,
                          description: dto.overview
                    )
                }
            })
            .eraseToAnyPublisher()
    }
}
