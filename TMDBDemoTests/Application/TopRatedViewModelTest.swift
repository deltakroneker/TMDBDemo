//
//  TopRatedViewModelTest.swift
//  TMDBDemoTests
//
//  Created by nikolamilic on 10/7/23.
//

import XCTest
import Combine
@testable import TMDBDemo

final class TopRatedViewModelTest: XCTestCase {
    func test_afterInit_hasNoMoviesNorLoaderTriggers() {
        let loader = PaginatedMovieLoaderSpy()
        let sut = makeSUT(loader: loader)
        
        XCTAssertEqual(sut.movies, [])
        XCTAssertEqual(sut.isLoadingNewPage, false)
        XCTAssertEqual(loader.pagesLoaded, [])
    }
    
    func test_afterInit_hasNoActionCalls() {
        var actionCallCount = 0
        let _ = makeSUT(movieTapAction: { _ in actionCallCount += 1 })
        
        XCTAssertEqual(actionCallCount, 0)
    }
    
    func test_callingLoadNextPageMultipleTimes_triggersLoaderWithCorrectPages() {
        let loader = PaginatedMovieLoaderSpy()
        let sut = makeSUT(loader: loader)
        
        sut.loadNextPage()
        sut.loadNextPage()
        sut.loadNextPage()
        
        XCTAssertEqual(loader.pagesLoaded, [1, 2, 3])
    }
    
    func test_callingLoadNextPageWhileIsLoadingNthPage_doesNotTriggerLoaderForNPlusOnePage() {
        let n = 4
        let loader = PaginatedMovieLoaderSpy()
        let sut = makeSUT(loader: loader)
        
        for _ in 1...n {
            sut.loadNextPage()
        }
        sut.isLoadingNewPage = true
        sut.loadNextPage()

        XCTAssertEqual(loader.pagesLoaded, Array(1...n))
    }
    
    func test_callingMovieAppearedWithLastLoadedMovie_triggersLoader() async  {
        let loader = PaginatedMovieLoaderSpy()
        let sut = makeSUT(loader: loader)
        sut.loadNextPage()
        sut.loadNextPage()

        sut.movieAppeared(sut.movies[sut.movies.count - 1])
                
        XCTAssertEqual(loader.pagesLoaded, [1, 2, 3])
    }
    
    func test_callingMovieTapped_triggersActionCallWithCorrectMovie() {
        var actionCalledMovieIds = [Int]()
        let movie = PaginatedMovieLoaderSpy.fakeMovies.randomElement()!
        let sut = makeSUT(movieTapAction: { movie in actionCalledMovieIds.append(movie.id) })
        
        sut.movieTapped(movie: movie)
        
        XCTAssertEqual(actionCalledMovieIds, [movie.id])
    }
    
    // Helpers:

    private func makeSUT(
        loader: PaginatedMovieLoader = PaginatedMovieLoaderSpy(),
        movieTapAction: @escaping ((Movie) -> Void) = { _ in }
    ) -> TopRatedViewModel {
        return TopRatedViewModel(loader: loader, movieTapAction: movieTapAction)
    }
    
    private class PaginatedMovieLoaderSpy: PaginatedMovieLoader {
        var pagesLoaded: [Int] = []
        
        func load(page: Int) -> AnyPublisher<[Movie], Error> {
            pagesLoaded.append(page)
            return Just(
                [
                    PaginatedMovieLoaderSpy.fakeMovies.randomElement()!,
                    PaginatedMovieLoaderSpy.fakeMovies.randomElement()!
                ]
            )
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        
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
