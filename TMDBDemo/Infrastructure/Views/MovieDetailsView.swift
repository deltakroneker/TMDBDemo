//
//  MovieDetailsView.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                KFImage(viewModel.brief.posterImageURL)
                    .requestModifier(KFExt.apiKey)
                    .placeholder({
                        Image("poster-placeholder")
                            .resizable()
                    })
                    .resizable()
                    .scaledToFill()
                    .frame(height: 500)
                    .clipped()
                
                LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(viewModel.brief.subtitle)
                            .foregroundColor(.white)
                            .font(.footnote)
                            .padding(.bottom, 1)
                        Text(viewModel.brief.genreDescription)
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .italic()
                            .padding(.bottom, 1)
                        Text(viewModel.brief.title)
                            .foregroundColor(.white)
                            .font(.headline)
                            .bold()
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            Task {
                                await viewModel.toggleFavorite()
                            }
                        }) {
                            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .tint(.pink)
                        }
                    }
                    .padding()
                }
            }
            Text(viewModel.description)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(movie: PreviewContentFakeData.movies().first!, favoritesService: FavoritesService(store: PreviewContentMovieStore())))
    }
}
