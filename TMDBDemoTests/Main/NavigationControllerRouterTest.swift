//
//  NavigationControllerRouterTest.swift
//  TMDBDemoTests
//
//  Created by nikolamilic on 10/7/23.
//

import XCTest
@testable import TMDBDemo

final class NavigationControllerRouterTest: XCTestCase {
    func test_onStart_showsTopRatedMoviesScreenInsideFirstTabsNavigationController() {
        let tabBarController = UITabBarController()
        let topRatedMoviesVC = UIViewController()
        self.factory.stubTopRatedMoviesVC(with: topRatedMoviesVC)
        let sut = NavigationControllerRouter(tabBarController, topRatedNavigationController: self.topRatedNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)

        sut.start()

        XCTAssertEqual(tabBarController.children[0], self.topRatedNavigationController)
        XCTAssertEqual(self.topRatedNavigationController.viewControllers, [topRatedMoviesVC])
    }
    
    func test_onStart_showsFavoriteMoviesScreenInsideSecondTabsNavigationController() {
        let tabBarController = UITabBarController()
        let favoriteMoviesVC = UIViewController()
        self.factory.stubFavoriteMoviesVC(with: favoriteMoviesVC)
        let sut = NavigationControllerRouter(tabBarController, favoritesNavigationController: self.favoritesNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)

        sut.start()

        XCTAssertEqual(tabBarController.children[1], self.favoritesNavigationController)
        XCTAssertEqual(self.favoritesNavigationController.viewControllers, [favoriteMoviesVC])
    }
    
    func test_onStart_showsMovieSearchScreenInsideThirdTabsNavigationController() {
        let tabBarController = UITabBarController()
        let movieSearchVC = UIViewController()
        self.factory.stubMovieSearchVC(with: movieSearchVC)
        let sut = NavigationControllerRouter(tabBarController, movieSearchNavigationController: self.movieSearchNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)

        sut.start()

        XCTAssertEqual(tabBarController.children[2], self.movieSearchNavigationController)
        XCTAssertEqual(self.movieSearchNavigationController.viewControllers, [movieSearchVC])
    }
    
    func test_onMovieTapActionWithinTopRatedMoviesScreen_pushesMovieDetailsScreenToFirstTabsNavigationController() {
        let tabBarController = UITabBarController()
        let topRatedMoviesVC = UIViewController()
        let movieDetailsVC = UIViewController()
        self.factory.stubTopRatedMoviesVC(with: topRatedMoviesVC)
        self.factory.stubMovieDetailsVC(with: movieDetailsVC)
        let sut = NavigationControllerRouter(tabBarController, topRatedNavigationController: self.topRatedNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        self.factory.movieTapActionOnTopRatedMoviesVC?(self.dummyMovie)
        
        XCTAssertEqual(tabBarController.children.first, self.topRatedNavigationController)
        XCTAssertEqual(self.topRatedNavigationController.viewControllers, [topRatedMoviesVC, movieDetailsVC])
    }
    
    func test_onMovieTapActionWithinFavoriteMoviesScreen_pushesMovieDetailsScreenToSecondTabsNavigationController() {
        let tabBarController = UITabBarController()
        let favoriteMoviesVC = UIViewController()
        let movieDetailsVC = UIViewController()
        self.factory.stubFavoriteMoviesVC(with: favoriteMoviesVC)
        self.factory.stubMovieDetailsVC(with: movieDetailsVC)
        let sut = NavigationControllerRouter(tabBarController, favoritesNavigationController: self.favoritesNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        self.factory.movieTapActionOnFavoriteMoviesVC?(self.dummyMovie)
        
        XCTAssertEqual(tabBarController.children[1], self.favoritesNavigationController)
        XCTAssertEqual(self.favoritesNavigationController.viewControllers, [favoriteMoviesVC, movieDetailsVC])
    }
    
    func test_onMovieTapActionWithinMovieSearchScreen_pushesMovieDetailsScreenToThirdTabsNavigationController() {
        let tabBarController = UITabBarController()
        let movieSearchVC = UIViewController()
        let movieDetailsVC = UIViewController()
        self.factory.stubMovieSearchVC(with: movieSearchVC)
        self.factory.stubMovieDetailsVC(with: movieDetailsVC)
        let sut = NavigationControllerRouter(tabBarController, movieSearchNavigationController: self.movieSearchNavigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        self.factory.movieTapActionOnMovieSearchVC?(self.dummyMovie)
        
        XCTAssertEqual(tabBarController.children[2], self.movieSearchNavigationController)
        XCTAssertEqual(self.movieSearchNavigationController.viewControllers, [movieSearchVC, movieDetailsVC])
    }
    
    // Helpers:
    
    private let factory = ViewControllerFactoryStub()
    private let topRatedNavigationController = NonAnimatedNavigationController()
    private let favoritesNavigationController = NonAnimatedNavigationController()
    private let movieSearchNavigationController = NonAnimatedNavigationController()
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
        var movieTapActionOnTopRatedMoviesVC: ((Movie) -> Void)?
        
        private var stubbedMovieDetailsVC: UIViewController?
        
        private var stubbedFavoriteMoviesVC: UIViewController?
        var movieTapActionOnFavoriteMoviesVC: ((Movie) -> Void)?
        
        private var stubbedMovieSearchVC: UIViewController?
        var movieTapActionOnMovieSearchVC: ((Movie) -> Void)?
        
        func stubTopRatedMoviesVC(with viewController: UIViewController) {
            stubbedTopRatedMoviesVC = viewController
        }
        
        func stubMovieDetailsVC(with viewController: UIViewController) {
            stubbedMovieDetailsVC = viewController
        }
        
        func stubFavoriteMoviesVC(with viewController: UIViewController) {
            stubbedFavoriteMoviesVC = viewController
        }
        
        func stubMovieSearchVC(with viewController: UIViewController) {
            stubbedMovieSearchVC = viewController
        }
        
        // Factory protocol
        
        func topRatedMoviesScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController {
            self.movieTapActionOnTopRatedMoviesVC = movieTapAction
            return stubbedTopRatedMoviesVC ?? UIViewController()
        }
        
        func movieDetailsScreen(movie: Movie) -> UIViewController {
            return stubbedMovieDetailsVC ?? UIViewController()
        }
        
        func favoriteMoviesScreen(movieTapAction: @escaping (TMDBDemo.Movie) -> Void) -> UIViewController {
            self.movieTapActionOnFavoriteMoviesVC = movieTapAction
            return stubbedFavoriteMoviesVC ?? UIViewController()
        }
        
        func movieSearchScreen(movieTapAction: @escaping (TMDBDemo.Movie) -> Void) -> UIViewController {
            self.movieTapActionOnMovieSearchVC = movieTapAction
            return stubbedMovieSearchVC ?? UIViewController()
        }
    }
}
