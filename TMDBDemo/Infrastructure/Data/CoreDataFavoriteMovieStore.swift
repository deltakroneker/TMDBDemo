//
//  CoreDataFavoriteMovieStore.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation

final class CoreDataFavoriteMovieStore: MovieStore {
    func store(movie: Movie) async throws -> Result<Bool, Error> {
        _ = await movie.toManagedObject(context: PersistenceController.shared.container.viewContext)
        PersistenceController.save()
        return .success(true)
    }
    
    func remove(id: Int) async throws -> Result<Bool, Error> {
        return .success(true)
    }
    
    func fetchAll() async throws -> Result<[Movie], Error> {
        let request = FavoriteMovieEntity.fetchRequest()

        do {
            let results = try PersistenceController.shared.container.viewContext.fetch(request)
            let movies = results.compactMap { Movie(managedObject: $0) }
            return .success(movies)
        } catch let err {
            return .failure(err)
        }
    }
}
