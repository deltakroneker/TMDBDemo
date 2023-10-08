//
//  MovieBriefViewModel.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import Foundation

struct MovieBriefViewModel {
    let id: Int
    let title: String
    let subtitle: String
    let genreDescription: String
    let posterImageUrlPath: String
    
    var posterImageURL: URL? {
        TMDBRequestProvider.posterUrl(for: posterImageUrlPath, customWidth: 300)
    }
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.name
        self.subtitle = "⭐️ \(movie.rating)"
        self.genreDescription = movie.genres.map({ $0.name }).joined(separator: ", ")
        self.posterImageUrlPath = movie.poster
    }
}
