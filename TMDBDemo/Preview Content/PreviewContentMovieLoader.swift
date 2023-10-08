//
//  PreviewContentMovieLoader.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine


struct PreviewContentFakeData {
    static func movies() -> [Movie] {
        [
            Movie(id: 0, name: "Inception", genres: [Genre(id: 3, name: "Action"), Genre(id: 4, name: "Sci-Fi")], poster: "/inception_poster.jpg", rating: 8.8, description: "Test description"),
            Movie(id: 1, name: "The Shawshank Redemption", genres: [Genre(id: 0, name: "Drama"), Genre(id: 5, name: "Crime")], poster: "/shawshank_redemption_poster.jpg", rating: 9.3, description: "Test description"),
            Movie(id: 2, name: "Pulp Fiction", genres: [Genre(id: 0, name: "Drama"), Genre(id: 6, name: "Crime"), Genre(id: 7, name: "Thriller")], poster: "/pulp_fiction_poster.jpg", rating: 8.9, description: "Test description"),
            Movie(id: 3, name: "Forrest Gump", genres: [Genre(id: 0, name: "Drama"), Genre(id: 2, name: "Romance")], poster: "/forrest_gump_poster.jpg", rating: 8.8, description: "Test description"),
            Movie(id: 4, name: "The Dark Knight", genres: [Genre(id: 3, name: "Action"), Genre(id: 6, name: "Crime"), Genre(id: 4, name: "Sci-Fi")], poster: "/dark_knight_poster.jpg", rating: 9.0, description: "Test description"),
            Movie(id: 5, name: "The Lord of the Rings: The Return of the King", genres: [Genre(id: 1, name: "Adventure"), Genre(id: 0, name: "Drama"), Genre(id: 3, name: "Action")], poster: "/lotr_return_king_poster.jpg", rating: 8.9, description: "Test description"),
            Movie(id: 6, name: "Schindler's List", genres: [Genre(id: 0, name: "Drama"), Genre(id: 5, name: "History")], poster: "/schindlers_list_poster.jpg", rating: 8.9, description: "Test description"),
            Movie(id: 7, name: "Fight Club", genres: [Genre(id: 0, name: "Drama"), Genre(id: 6, name: "Crime"), Genre(id: 7, name: "Thriller")], poster: "/fight_club_poster.jpg", rating: 8.8, description: "Test description")
        ]
    }
}

class PreviewContentMovieLoader: PaginatedMovieLoader {
    func load(page: Int) -> AnyPublisher<[Movie], Error> {
        return Just(PreviewContentFakeData.movies())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
