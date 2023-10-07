//
//  TMDBGenreLoader.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import Foundation
import Combine

class TMDBGenreLoader: GenreLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadAll() -> AnyPublisher<[Genre], Error> {
        return self.client.publisher(request: TMDBRequestProvider.genres.makeRequest)
            .tryMap(TMDBGenreMapper.mapGenres)
            .map({ dtos in
                dtos.map { dto in
                    Genre(id: dto.id,
                          name: dto.name)
                }
            })
            .eraseToAnyPublisher()
    }
}
