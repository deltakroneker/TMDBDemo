//
//  KingfisherExt.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/7/23.
//

import SwiftUI
import Kingfisher

enum KFExt {
    static let apiKey = AnyModifier { request in
        var r = request
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as! String
        if #available(iOS 16.0, *) {
            r.url?.append(queryItems: [URLQueryItem(name: "api_key", value: apiKey)])
        } else {
            r.url?.appendQueryItem(name: "api_key", value: apiKey)
        }
        print(r.url!)
        return r
    }
}
