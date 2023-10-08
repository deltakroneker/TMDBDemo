//
//  CoreDataFavoriteMovieStore.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation
import CoreData

final class CoreDataFavoriteMovieStore: MovieStore {
    func store(movie: Movie) async throws -> Result<Bool, Error> {
        _ = await movie.toManagedObject(context: PersistenceController.shared.container.viewContext)
        PersistenceController.save()
        return .success(true)
    }
    
    func remove(id: Int) async throws -> Result<Bool, Error> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavoriteMovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id==\(id)")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try PersistenceController.shared.container.viewContext.execute(deleteRequest)
            PersistenceController.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
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
