//
//  PreviewContentMovieSearcher.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import Combine

class PreviewContentMovieSearcher: PaginatedMovieSearcher {
    func search(query: String, page: Int) -> AnyPublisher<[Movie], Error> {
        return Just(PreviewContentFakeData.movies())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
