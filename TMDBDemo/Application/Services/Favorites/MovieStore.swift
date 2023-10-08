//
//  MovieStore.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation

protocol MovieStore {
    func store(movie: Movie) async throws -> Result<Bool, Error>
    func remove(id: Int) async throws -> Result<Bool, Error>
    func fetchAll() async throws -> Result<[Movie], Error>
}
