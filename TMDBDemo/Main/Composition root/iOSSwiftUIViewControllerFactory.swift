//
//  iOSSwiftUIViewControllerFactory.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import UIKit
import SwiftUI
import Combine

class iOSSwiftUIViewControllerFactory: ViewControllerFactory {
    let genresService: GenresService
    
    init(genresService: GenresService) {
        self.genresService = genresService
    }
    
    func topRatedMoviesScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController {
        let loader: PaginatedMovieLoader = MainQueueDispatchDecorator(
            TMDBRemoteTopRatedMovieLoader(client: iOSSwiftUIViewControllerFactory.createAuthenticatedHTTPClient(), genresService: genresService)
        )
        let viewModel = TopRatedViewModel(loader: loader, movieTapAction: movieTapAction)
        let view = TopRatedView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    @MainActor func movieDetailsScreen(movie: Movie) -> UIViewController {
        let favService = LocalStoreFavoritesService(store: CoreDataFavoriteMovieStore())
        let viewModel = MovieDetailsViewModel(movie: movie, favoritesService: favService)
        let view = MovieDetailsView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    @MainActor func favoriteMoviesScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController {
        let favService = LocalStoreFavoritesService(store: CoreDataFavoriteMovieStore())
        let viewModel = FavoriteMoviesViewModel(favoritesService: favService, movieTapAction: movieTapAction)
        let view = FavoriteMoviesView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func movieSearchScreen(movieTapAction: @escaping (Movie) -> Void) -> UIViewController {
        let searcher: PaginatedMovieSearcher = MainQueueDispatchDecorator(
            TMDBMovieSearcher(client: iOSSwiftUIViewControllerFactory.createAuthenticatedHTTPClient(),genresService: genresService)
        )
        let viewModel = MovieSearchViewModel(searcher: searcher, movieTapAction: movieTapAction)
        let view = MovieSearchView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}

// MARK: AuthenticatedHTTPClientDecorator extension

extension iOSSwiftUIViewControllerFactory {
    static func createAuthenticatedHTTPClient() -> HTTPClient {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as! String
        return AuthenticatedHTTPClientDecorator(httpClient: URLSession.shared, apiKey: apiKey)
    }
}

// MARK: MainQueueDispatchDecorator extensions

extension MainQueueDispatchDecorator: PaginatedMovieLoader where T == PaginatedMovieLoader {
    func load(page: Int) -> AnyPublisher<[Movie], Error> {
        return decoratee.load(page: page)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension MainQueueDispatchDecorator: GenreLoader where T == GenreLoader {
    func loadAll() -> AnyPublisher<[Genre], Error> {
        return decoratee.loadAll()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension MainQueueDispatchDecorator: PaginatedMovieSearcher where T == PaginatedMovieSearcher {
    func search(query: String, page: Int) -> AnyPublisher<[Movie], Error> {
        return decoratee.search(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
