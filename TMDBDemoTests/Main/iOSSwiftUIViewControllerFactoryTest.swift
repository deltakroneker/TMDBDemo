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
    
    // Helpers:
    
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
