//
//  PreviewContentMovieLoader.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Combine

class PreviewContentMovieLoader: PaginatedMovieLoader {
    func load(page: Int) -> AnyPublisher<[Movie], Error> {
        return Just(PreviewContentFakeData.movies())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
