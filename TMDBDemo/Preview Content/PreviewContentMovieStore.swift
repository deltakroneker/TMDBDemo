//
//  PreviewContentMovieStore.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation

final class PreviewContentMovieStore: MovieStore {
    func store(movie: Movie) async throws -> Result<Bool, Error> {
        return .success(true)
    }
    
    func remove(id: Int) async throws -> Result<Bool, Error> {
        return .success(true)
    }
    
    func fetchAll() async throws -> Result<[Movie], Error> {
        return .success([
            Movie(id: 3, name: "Forrest Gump", genres: [Genre(id: 0, name: "Drama"), Genre(id: 2, name: "Romance")], poster: "/forrest_gump_poster.jpg", rating: 8.8, description: "Test description"),
            Movie(id: 4, name: "The Dark Knight", genres: [Genre(id: 3, name: "Action"), Genre(id: 6, name: "Crime"), Genre(id: 4, name: "Sci-Fi")], poster: "/dark_knight_poster.jpg", rating: 9.0, description: "Test description"),
        ])
    }
}
