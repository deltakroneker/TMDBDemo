//
//  FavoriteMoviesViewModelTest.swift
//  TMDBDemoTests
//
//  Created by nikolamilic on 10/9/23.
//

import XCTest
import Combine
@testable import TMDBDemo

final class FavoriteMoviesViewModelTest: XCTestCase {
    @MainActor func test_afterInit_hasNoMoviesNorServiceFetches() {
        let favService = LocalStoreFavoritesServiceSpy()
        let sut = makeSUT(favoritesService: favService)
        
        XCTAssertEqual(sut.movies, [])
        XCTAssertEqual(favService.fetchAllFavoritesResults, [])
    }
    
    @MainActor func test_afterInit_hasNoActionCalls() {
        var actionCallCount = 0
        let _ = makeSUT(movieTapAction: { _ in actionCallCount += 1 })
        
        XCTAssertEqual(actionCallCount, 0)
    }
    
    func test_callingLoadFavorites_triggersServiceFetch() async {
        let favService = LocalStoreFavoritesServiceSpy()
        let sut = await makeSUT(favoritesService: favService)
        
        await sut.loadFavorites()
        
        XCTAssertNotNil(favService.fetchAllFavoritesResults.first)
    }

    @MainActor func test_callingMovieTapped_triggersActionCallWithCorrectMovie() {
        var actionCalledMovieIds = [Int]()
        let movie = LocalStoreFavoritesServiceSpy.fakeMovies.randomElement()!
        let sut = makeSUT(movieTapAction: { movie in actionCalledMovieIds.append(movie.id) })
        
        sut.movieTapped(movie: movie)
        
        XCTAssertEqual(actionCalledMovieIds, [movie.id])
    }
    
    // Helpers:

    @MainActor private func makeSUT(
        favoritesService: FavoritesService = LocalStoreFavoritesServiceSpy(),
        movieTapAction: @escaping ((Movie) -> Void) = { _ in }
    ) -> FavoriteMoviesViewModel {
        return FavoriteMoviesViewModel(favoritesService: favoritesService, movieTapAction: movieTapAction)
    }
    
    private class LocalStoreFavoritesServiceSpy: FavoritesService {
        var fetchAllFavoritesResults: [[Movie]] = []
        
        func fetchAllFavorites() async -> [Movie] {
            let favs = [
                LocalStoreFavoritesServiceSpy.fakeMovies.randomElement()!,
                LocalStoreFavoritesServiceSpy.fakeMovies.randomElement()!
            ]
            self.fetchAllFavoritesResults.append(favs)
            return favs
        }
        
        // ✨✨✨
        // These three methods are not used within this view model: which indicates that the FavoritesService
        // protocol is not 100% broken down into smaller chunks (Interface segragation principle)
        func isFavorite(id: Int) async -> Bool { return true }
        func saveToFavorites(movie: Movie) async -> Bool { return true }
        func removeFromFavorites(id: Int) async -> Bool { return true }
        // ✨✨✨

        static let fakeMovies: [Movie] = [
            Movie(id: 0, name: "Inception", genres: [Genre(id: 3, name: "Action"), Genre(id: 4, name: "Sci-Fi")], poster: "/inception_poster.jpg", rating: 8.8, description: "Test"),
            Movie(id: 1, name: "The Shawshank Redemption", genres: [Genre(id: 0, name: "Drama"), Genre(id: 5, name: "Crime")], poster: "/shawshank_redemption_poster.jpg", rating: 9.3, description: "Test"),
            Movie(id: 2, name: "Pulp Fiction", genres: [Genre(id: 0, name: "Drama"), Genre(id: 6, name: "Crime"), Genre(id: 7, name: "Thriller")], poster: "/pulp_fiction_poster.jpg", rating: 8.9, description: "Test"),
            Movie(id: 3, name: "Forrest Gump", genres: [Genre(id: 0, name: "Drama"), Genre(id: 2, name: "Romance")], poster: "/forrest_gump_poster.jpg", rating: 8.8, description: "Test"),
            Movie(id: 4, name: "The Dark Knight", genres: [Genre(id: 3, name: "Action"), Genre(id: 6, name: "Crime"), Genre(id: 4, name: "Sci-Fi")], poster: "/dark_knight_poster.jpg", rating: 9.0, description: "Test"),
            Movie(id: 5, name: "The Lord of the Rings: The Return of the King", genres: [Genre(id: 1, name: "Adventure"), Genre(id: 0, name: "Drama"), Genre(id: 3, name: "Action")], poster: "/lotr_return_king_poster.jpg", rating: 8.9, description: "Test"),
            Movie(id: 6, name: "Schindler's List", genres: [Genre(id: 0, name: "Drama"), Genre(id: 5, name: "History")], poster: "/schindlers_list_poster.jpg", rating: 8.9, description: "Test"),
            Movie(id: 7, name: "Fight Club", genres: [Genre(id: 0, name: "Drama"), Genre(id: 6, name: "Crime"), Genre(id: 7, name: "Thriller")], poster: "/fight_club_poster.jpg", rating: 8.8, description: "Test")
        ]
    }
}
