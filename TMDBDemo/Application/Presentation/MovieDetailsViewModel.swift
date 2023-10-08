//
//  MovieDetailsViewModel.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation

final class MovieDetailsViewModel: ObservableObject {
    let brief: MovieBriefViewModel
    let description: String
    private let toggleFavouriteAction: (Movie) -> Void
    
    init(movie: Movie, toggleFavouriteAction: @escaping (Movie) -> Void) {
        self.brief = MovieBriefViewModel(movie: movie)
        self.description = movie.description
        self.toggleFavouriteAction = toggleFavouriteAction
    }
}
