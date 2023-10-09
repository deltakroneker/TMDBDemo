//
//  PaginatedMovieSearcher.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import Combine

protocol PaginatedMovieSearcher {
    func search(query: String, page: Int) -> AnyPublisher<[Movie], Error>
}
