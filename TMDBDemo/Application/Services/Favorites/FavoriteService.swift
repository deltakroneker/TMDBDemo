//
//  FavoriteService.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import Foundation

protocol FavoritesService {
    func isFavorite(id: Int) async -> Bool
    func saveToFavorites(movie: Movie) async -> Bool
    func removeFromFavorites(id: Int) async -> Bool
    func fetchAllFavorites() async -> [Movie]
}
