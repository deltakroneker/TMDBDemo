//
//  FavoriteMoviesViewModel.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import Foundation
import Combine

@MainActor
final class FavoriteMoviesViewModel: ObservableObject {
    @Published var movies: [Movie]
    private let favoritesService: FavoritesService
    private let movieTapAction: (Movie) -> Void
    
    init(favoritesService: FavoritesService, movieTapAction: @escaping (Movie) -> Void) {
        self.movies = []
        self.favoritesService = favoritesService
        self.movieTapAction = movieTapAction
    }
    
    func loadFavorites() async {
        self.movies = await favoritesService.fetchAllFavorites()
    }
    
    func movieTapped(movie: Movie) {
        movieTapAction(movie)
    }
}
