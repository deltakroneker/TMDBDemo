//
//  TopRatedView.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import SwiftUI
import Combine
import Kingfisher

struct TopRatedView: View {
    @ObservedObject var viewModel: TopRatedViewModel
    
    private let twoColumnGridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: twoColumnGridLayout, spacing: 10) {
                    ForEach(viewModel.movies, id: \.self) { movie in
                        MoviePosterView(viewModel: MoviePosterViewModel(movie: movie))
                            .onAppear {
                                viewModel.movieAppeared(movie)
                            }
                    }
                }
                .padding(10)
            }
        }
    }
}

struct TopRatedView_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedView(viewModel: TopRatedViewModel(loader: PreviewContentMovieLoader(), movieTapAction: { _ in }))
    }
}
