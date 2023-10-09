//
//  MovieSearchViewModel.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import SwiftUI
import Combine

final class MovieSearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var queryText: String = ""
    var isPerformSearchDisabled: Bool { queryText.isEmpty }
    var isLoadingNewPage: Bool = false
    private var page = 1
    private var lastQuery: String = ""
    private let searcher: PaginatedMovieSearcher
    private let movieTapAction: (Movie) -> Void
    private var bag = Set<AnyCancellable>()
    
    init(searcher: PaginatedMovieSearcher, movieTapAction: @escaping (Movie) -> Void) {
        self.searcher = searcher
        self.movieTapAction = movieTapAction
    }

    func movieAppeared(_ movie: Movie) {
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -1)
        if movies[thresholdIndex] == movie {
            performSearch()
        }
    }
    
    func performSearch() {
        guard !isPerformSearchDisabled else {
            clearSearchResults()
            return
        }
        guard !isLoadingNewPage else {
            return
        }
        isLoadingNewPage = true
        
        if self.lastQuery != self.queryText {
            self.movies = []
            self.page = 1
            self.lastQuery = self.queryText
        }
        
        searcher.search(query: queryText, page: page)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                // TODO: Handle searcher error cases
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
    
    func clearSearchResults() {
        self.movies = []
        self.queryText = ""
        self.lastQuery = ""
        self.page = 1
    }
}
