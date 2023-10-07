//
//  GenreLoader.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import Foundation
import Combine

protocol GenreLoader {
    func loadAll() -> AnyPublisher<[Genre], Error>
}
