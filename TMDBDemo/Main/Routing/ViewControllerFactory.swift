//
//  ViewControllerFactory.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import UIKit

protocol ViewControllerFactory {
    func topRatedMoviesScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController
    func movieDetailsScreen(movie: Movie) -> UIViewController
    func favoriteMoviesScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController
    func movieSearchScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController
}
