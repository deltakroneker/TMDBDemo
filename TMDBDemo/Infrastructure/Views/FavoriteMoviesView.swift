//
//  FavoriteMoviesView.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import SwiftUI

struct FavoriteMoviesView: View {
    @ObservedObject var viewModel: FavoriteMoviesViewModel
    
    private let twoColumnGridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: twoColumnGridLayout, spacing: 10) {
                    ForEach(viewModel.movies, id: \.self) { movie in
                        MovieBriefView(viewModel: MovieBriefViewModel(movie: movie))
                            .onTapGesture {
                                viewModel.movieTapped(movie: movie)
                            }
                    }
                }
                .padding(10)
            }
        }
        .onAppear {
            Task {
                await viewModel.loadFavorites()
            }
        }
    }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesView(viewModel: FavoriteMoviesViewModel(favoritesService: LocalStoreFavoritesService(store: PreviewContentMovieStore()), movieTapAction: { _ in }))
    }
}
