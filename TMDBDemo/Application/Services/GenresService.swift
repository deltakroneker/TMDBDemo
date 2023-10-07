//
//  GenresService.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import Foundation
import Combine

final class GenresService {
    private var genres: [Genre] = []
    private let loader: GenreLoader
    private var bag = Set<AnyCancellable>()
    
    init(loader: GenreLoader) {
        self.loader = loader
        loader.loadAll()
            .sink { _ in } receiveValue: { genres in
                self.genres = genres
            }
            .store(in: &bag)
    }
    
    func genreTitle(for id: Int) -> String {
        genres.first(where: { $0.id == id })?.name ?? "Unknown"
    }
}
