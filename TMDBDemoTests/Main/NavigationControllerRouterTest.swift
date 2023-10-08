//
//  NavigationControllerRouterTest.swift
//  TMDBDemoTests
//
//  Created by nikolamilic on 10/7/23.
//

import XCTest
@testable import TMDBDemo

final class NavigationControllerRouterTest: XCTestCase {
    func test_onStart_showsTabBarControllerWithTopRatedMoviesScreenInsideNavigationController() {
        let tabBarController = UITabBarController()
        let topRatedMoviesVC = UIViewController()
        self.factory.stubTopRatedMoviesVC(with: topRatedMoviesVC)
        let sut = NavigationControllerRouter(tabBarController, topRatedNavigationController: self.topRatedNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)

        sut.start()

        XCTAssertEqual(tabBarController.children.first, self.topRatedNavigationController)
        XCTAssertEqual(self.topRatedNavigationController.viewControllers, [topRatedMoviesVC])
    }
    
    func test_onMovieTapAction_pushesMovieDetailsScreenToNavigationController() {
        let tabBarController = UITabBarController()
        let topRatedMoviesVC = UIViewController()
        let movieDetailsVC = UIViewController()
        self.factory.stubTopRatedMoviesVC(with: topRatedMoviesVC)
        self.factory.stubMovieDetailsVC(with: movieDetailsVC)
        let sut = NavigationControllerRouter(tabBarController, topRatedNavigationController: self.topRatedNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        self.factory.movieTapAction?(self.dummyMovie)
        
        XCTAssertEqual(tabBarController.children.first, self.topRatedNavigationController)
        XCTAssertEqual(self.topRatedNavigationController.viewControllers, [topRatedMoviesVC, movieDetailsVC])
    }
    
    // Helpers:
    
    private let factory = ViewControllerFactoryStub()
    private let topRatedNavigationController = NonAnimatedNavigationController()
    private let dispatchQueue = DispatchFake()
    private let dummyMovie = Movie(id: 0, name: "Inception", genres: [Genre(id: 3, name: "Action"), Genre(id: 4, name: "Sci-Fi")], poster: "/inception_poster.jpg", rating: 8.8, description: "Test")
    
    private class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    private class DispatchFake: Dispatching {
        func async(execute workItem: DispatchWorkItem) {
            workItem.perform()
        }
    }
    
    private class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedTopRatedMoviesVC: UIViewController?
        var movieTapAction: ((Movie) -> Void)?
        
        private var stubbedMovieDetailsVC: UIViewController?
        
        func stubTopRatedMoviesVC(with viewController: UIViewController) {
            stubbedTopRatedMoviesVC = viewController
        }
        
        func stubMovieDetailsVC(with viewController: UIViewController) {
            stubbedMovieDetailsVC = viewController
        }
        
        // Factory protocol
        
        func topRatedMoviesScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController {
            self.movieTapAction = movieTapAction
            return stubbedTopRatedMoviesVC ?? UIViewController()
        }
        
        func movieDetailsScreen(movie: Movie) -> UIViewController {
            return stubbedMovieDetailsVC ?? UIViewController()
        }
    }
}
