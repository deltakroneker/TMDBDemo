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
        let favoritesService = FavoritesService(store: CoreDataFavoriteMovieStore())
        let viewModel = MovieDetailsViewModel(movie: movie, favoritesService: favoritesService)
        let view = MovieDetailsView(viewModel: viewModel)
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
