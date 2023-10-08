//
//  NavigationControllerRouter.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import UIKit

final class NavigationControllerRouter {
    private let tabBarController: UITabBarController
    private let topRatedNavigationController = UINavigationController()
    private let factory: ViewControllerFactory
    private let dispatchQueue: Dispatching
    
    init(_ tabBarController: UITabBarController, factory: ViewControllerFactory, dispatchQueue: Dispatching = DispatchQueue.main) {
        self.tabBarController = tabBarController
        self.factory = factory
        self.dispatchQueue = dispatchQueue
        
        self.topRatedNavigationController.tabBarItem = UITabBarItem(title: "Top Rated", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        self.tabBarController.addChild(topRatedNavigationController)
    }
    
    func start() {
        let topRatedMoviesVC = factory.topRatedMoviesScreen(movieTapAction: topRatedMoviesScreenMovieTapAction)
        self.topRatedNavigationController.pushViewController(topRatedMoviesVC, animated: true)
    }
    
    private func topRatedMoviesScreenMovieTapAction(_ movie: Movie) {
        // TODO: Handle movie tap
        dispatchQueue.async(execute: DispatchWorkItem(block: {
            let movieDetailsVC = self.factory.movieDetailsScreen(movie: movie, toggleFavouriteAction: self.toggleFavouriteAction)
            self.topRatedNavigationController.pushViewController(movieDetailsVC, animated: true)
        }))
    }
    
    private func toggleFavouriteAction(_ movie: Movie) {
        //TODO: Handle toggling favourite
    }
}
