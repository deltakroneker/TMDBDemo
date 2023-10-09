//
//  iOSSwiftUIViewControllerFactoryTest.swift
//  TMDBDemoTests
//
//  Created by nikolamilic on 10/7/23.
//

import XCTest
import SwiftUI
import Combine
@testable import TMDBDemo

final class iOSSwiftUIViewControllerFactoryTest: XCTestCase {
    func test_topRatedMoviesScreen_createsControllerWithTopRatedViewAsRootView() {
        let sut = makeSUT()
        let controller = sut.topRatedMoviesScreen(movieTapAction: { _ in }) as? UIHostingController<TopRatedView>
        
        XCTAssertNotNil(controller)
    }
    
    @MainActor func test_movieDetailsScreen_createsControllerWithMovieDetailsViewAsRootView() {
        let sut = makeSUT()
        let controller = sut.movieDetailsScreen(movie: self.dummyMovie) as? UIHostingController<MovieDetailsView>
        
        XCTAssertNotNil(controller)
    }
    
    @MainActor func test_favoriteMoviesScreen_createsControllerWithFavoriteMoviesViewAsRootView() {
        let sut = makeSUT()
        let controller = sut.favoriteMoviesScreen(movieTapAction: { _ in }) as? UIHostingController<FavoriteMoviesView>
        
        XCTAssertNotNil(controller)
    }
    
    @MainActor func test_movieSearchScreen_createsControllerWithMovieSearchViewAsRootView() async {
        let sut = makeSUT()
        let controller = sut.movieSearchScreen(movieTapAction: { _ in }) as? UIHostingController<MovieSearchView>
        
        XCTAssertNotNil(controller)
    }
    
    // Helpers:
    
    private let dummyMovie = Movie(id: 0, name: "Inception", genres: [Genre(id: 3, name: "Action"), Genre(id: 4, name: "Sci-Fi")], poster: "/inception_poster.jpg", rating: 8.8, description: "Test")
    
    private func makeSUT() -> iOSSwiftUIViewControllerFactory {
        return iOSSwiftUIViewControllerFactory(genresService: GenresService(loader: DummyGenreLoader()))
    }
    
    private class DummyGenreLoader: GenreLoader {
        func loadAll() -> AnyPublisher<[TMDBDemo.Genre], Error> {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
