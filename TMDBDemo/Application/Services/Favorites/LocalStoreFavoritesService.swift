//
//  LocalStoreFavoritesService.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation

final class LocalStoreFavoritesService: FavoritesService {
    let store: MovieStore
    
    init(store: MovieStore) {
        self.store = store
    }
    
    func isFavorite(id: Int) async -> Bool {
        // TODO: Write a more optimised query within the store itself for this purpose
        return await fetchAllFavorites().first(where: { $0.id == id }) != nil
    }
    
    func saveToFavorites(movie: Movie) async -> Bool {
        switch try? await store.store(movie: movie) {
        case .success(let succ):
            return succ
        default:
            return false
        }
    }
    
    func removeFromFavorites(id: Int) async -> Bool {
        switch try? await store.remove(id: id) {
        case .success(let succ):
            return succ
        default:
            return false
        }
    }
    
    func fetchAllFavorites() async -> [Movie] {
        switch try? await store.fetchAll() {
        case .success(let movies):
            return movies
        default:
            return []
        }
    }
}
