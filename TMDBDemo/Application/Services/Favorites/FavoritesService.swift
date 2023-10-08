//
//  FavoritesService.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation

final class FavoritesService {
    let store: MovieStore
    
    init(store: MovieStore) {
        self.store = store
    }
    
    func isFavorite(id: Int) async -> Bool {
        return false
    }
    
    func saveToFavorites(movie: Movie) async {
        _ = try? await store.store(movie: movie)
    }
    
    func removeFromFavorites(id: Int) async {
        _ = try? await store.remove(id: id)
    }
    
    func fetchAllFavorites() async -> [Movie] {
        let res = try? await store.fetchAll()
        switch res {
        case .success(let movies):
            return movies
        default:
            return []
        }
    }
}
