//
//  MovieSearchBriefView.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/9/23.
//

import SwiftUI
import Kingfisher

struct MovieSearchBriefView: View {
    let viewModel: MovieBriefViewModel
    
    var body: some View {
        ZStack {
            ZStack {
                KFImage(viewModel.posterImageURL)
                    .requestModifier(KFExt.apiKey)
                    .placeholder({
                        Image("poster-placeholder")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    })
                    .resizable()
                    .scaledToFill()
                
                LinearGradient(colors: [.black, .clear], startPoint: .leading, endPoint: .trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: 90)
            .clipped()

            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(viewModel.subtitle) - \(viewModel.title)")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(viewModel.genreDescription)
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .italic()
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct MovieSearchBriefView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchBriefView(viewModel: MovieBriefViewModel(movie: PreviewContentFakeData.movies().first!))
            .previewLayout(.sizeThatFits)
    }
}
