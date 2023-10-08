//
//  MovieBriefView.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import SwiftUI
import Kingfisher

struct MovieBriefView: View {
    let viewModel: MovieBriefViewModel
    
    var body: some View {
        ZStack {
            KFImage(viewModel.posterImageURL)
                .requestModifier(KFExt.apiKey)
                .placeholder({
                    Image("poster-placeholder")
                        .resizable()
                        .clipped()
                })
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                .clipped()
            
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text(viewModel.subtitle)
                        .foregroundColor(.white)
                        .font(.footnote)
                        .padding(.bottom, 1)
                    Text(viewModel.genreDescription)
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .italic()
                        .padding(.bottom, 1)
                    Text(viewModel.title)
                        .foregroundColor(.white)
                        .font(.headline)
                        .bold()
                }
                Spacer()
            }
            .padding(8)
        }
    }
}

struct MovieBriefView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBriefView(viewModel: MovieBriefViewModel(movie: PreviewContentFakeData.movies().first!))
            .previewLayout(.sizeThatFits)
    }
}
