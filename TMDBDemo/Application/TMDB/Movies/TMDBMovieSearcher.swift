//
//  TMDBMovieSearcher.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import Combine

class TMDBMovieSearcher: PaginatedMovieSearcher {
    let client: HTTPClient
    let genresService: GenresService
    
    init(client: HTTPClient, genresService: GenresService) {
        self.client = client
        self.genresService = genresService
    }
    
    func search(query: String, page: Int) -> AnyPublisher<[Movie], Error> {
        return self.client.publisher(request: TMDBRequestProvider.search(q: query, p: page).makeRequest)
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
