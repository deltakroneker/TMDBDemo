//
//  MovieExt.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import Foundation

extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
