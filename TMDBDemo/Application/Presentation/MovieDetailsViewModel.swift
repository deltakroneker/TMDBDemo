//
//  MovieDetailsViewModel.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    let brief: MovieBriefViewModel
    let description: String
    
    private let favoritesService: FavoritesService
    private let entity: Movie
    
    init(movie: Movie, favoritesService: FavoritesService) {
        self.brief = MovieBriefViewModel(movie: movie)
        self.description = movie.description
        self.favoritesService = favoritesService
        self.entity = movie
        
        Task { [weak self] in
            self?.isFavorite = await favoritesService.isFavorite(id: movie.id)
        }
    }
    
    func toggleFavorite() async {
        let success = isFavorite ? await favoritesService.removeFromFavorites(id: entity.id) : await favoritesService.saveToFavorites(movie: entity)
        if success {
            isFavorite.toggle()
        }
    }
}
