//
//  TopRatedViewModel.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation
import Combine

final class TopRatedViewModel: ObservableObject {
    @Published var movies: [Movie]
    var isLoadingNewPage: Bool = false
    private var page = 1
    private let loader: PaginatedMovieLoader
    private let movieTapAction: (Movie) -> Void
    private var bag = Set<AnyCancellable>()
    
    init(loader: PaginatedMovieLoader, movieTapAction: @escaping (Movie) -> Void) {
        self.movies = []
        self.loader = loader
        self.movieTapAction = movieTapAction        
    }
    
    func movieAppeared(_ movie: Movie) {
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -1)
        if movies[thresholdIndex] == movie {
            loadNextPage()
        }
    }
    
    func loadNextPage() {
        guard !isLoadingNewPage else {
            return
        }
        isLoadingNewPage = true
        
        loader.load(page: page)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                // TODO: Handle loader error cases
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
