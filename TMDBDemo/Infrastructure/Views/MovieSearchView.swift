//
//  MovieSearchView.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import SwiftUI

struct MovieSearchView: View {
    @Environment(\.isSearching) private var isSearching: Bool
    
    @ObservedObject var viewModel: MovieSearchViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.movies, id: \.self) { movie in
                MovieSearchBriefView(viewModel: MovieBriefViewModel(movie: movie))
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        viewModel.movieTapped(movie: movie)
                    }
                    .onAppear {
                        viewModel.movieAppeared(movie)
                    }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .listStyle(.plain)
        .clipped()
        .searchable(text: $viewModel.queryText)
        .onSubmit(of: .search, viewModel.performSearch)
        .onChange(of: viewModel.queryText) { queryText in
            if queryText.isEmpty && !isSearching {
                viewModel.clearSearchResults()
            }
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView(viewModel: MovieSearchViewModel(searcher: PreviewContentMovieSearcher(), movieTapAction: { _ in }))
    }
}
