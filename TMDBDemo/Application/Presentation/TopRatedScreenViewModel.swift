//
//  TopRatedScreenViewModel.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine

final class TopRatedScreenViewModel: ObservableObject {
    @Published var movies: [Movie]
    private var isLoadingNewPage: Bool = false
    private var page = 0
    private let loader: PaginatedMovieLoader
    private let movieTapAction: (Movie) -> Void
    private var bag = Set<AnyCancellable>()
    
    init(loader: PaginatedMovieLoader, movieTapAction: @escaping (Movie) -> Void) {
        self.movies = []
        self.loader = loader
        self.movieTapAction = movieTapAction
        
        loadTopRatedMovies()
    }
    
    func loadTopRatedMovies() {
        guard !isLoadingNewPage else {
            return
        }
        isLoadingNewPage = true
        
        loader.load(page: page)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
                self.page = self.page + 1
                self.isLoadingNewPage = false
            }, receiveValue: { [weak self] newMovies in
                guard let self = self else { return }
                self.movies.append(contentsOf: newMovies)
            })
            .store(in: &bag)
    }
    
    func movieTapped(movie: Movie) {
        movieTapAction(movie)
    }
}
