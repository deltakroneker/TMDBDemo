//
//  PaginatedMovieLoader.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine

protocol PaginatedMovieLoader {
    func load(page: Int) -> AnyPublisher<[Movie], Error>
}
