//
//  TopRatedView.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import SwiftUI
import Combine

struct TopRatedView: View {
    @ObservedObject var viewModel: TopRatedViewModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.movies, id: \.self) { movie in
                        Text(movie.name)
                            .onAppear(){
                                viewModel.movieAppeared(movie)
                            }
                    }
                }
            }
        }
    }
}

struct TopRatedView_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedView(viewModel: TopRatedViewModel(loader: PreviewContentMovieLoader(), movieTapAction: { _ in }))
    }
}

extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
