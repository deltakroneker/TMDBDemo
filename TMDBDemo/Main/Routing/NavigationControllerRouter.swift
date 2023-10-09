//
//  NavigationControllerRouter.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import UIKit

final class NavigationControllerRouter {
    private let tabBarController: UITabBarController
    private let topRatedNavigationController: UINavigationController
    private let favoritesNavigationController: UINavigationController
    private let factory: ViewControllerFactory
    private let dispatchQueue: Dispatching
    
    init(
        _ tabBarController: UITabBarController,
        topRatedNavigationController: UINavigationController = UINavigationController(),
        favoritesNavigationController: UINavigationController = UINavigationController(),
        factory: ViewControllerFactory,
        dispatchQueue: Dispatching = DispatchQueue.main
    ) {
        self.tabBarController = tabBarController
        self.topRatedNavigationController = topRatedNavigationController
        self.favoritesNavigationController = favoritesNavigationController
        self.factory = factory
        self.dispatchQueue = dispatchQueue
        
        self.topRatedNavigationController.tabBarItem = UITabBarItem(title: "Top Rated", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        self.favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))

        self.tabBarController.addChild(self.topRatedNavigationController)
        self.tabBarController.addChild(self.favoritesNavigationController)
    }
    
    func start() {
        let topRatedMoviesVC = factory.topRatedMoviesScreen(movieTapAction: topRatedMoviesScreenMovieTapAction)
        self.topRatedNavigationController.pushViewController(topRatedMoviesVC, animated: true)
        
        let favoriteMoviesVC = factory.favoriteMoviesScreen(movieTapAction: favoriteMoviesScreenMovieTapAction)
        self.favoritesNavigationController.pushViewController(favoriteMoviesVC, animated: true)
    }
    
    private func topRatedMoviesScreenMovieTapAction(_ movie: Movie) {
        dispatchQueue.async(execute: DispatchWorkItem(block: {
            let movieDetailsVC = self.factory.movieDetailsScreen(movie: movie)
            self.topRatedNavigationController.pushViewController(movieDetailsVC, animated: true)
        }))
    }
    
    private func favoriteMoviesScreenMovieTapAction(_ movie: Movie) {
        dispatchQueue.async(execute: DispatchWorkItem(block: {
            let movieDetailsVC = self.factory.movieDetailsScreen(movie: movie)
            self.favoritesNavigationController.pushViewController(movieDetailsVC, animated: true)
        }))
    }
}
