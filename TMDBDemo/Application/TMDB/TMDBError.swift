//
//  TMDBAPIError.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

enum TMDBError: Error {
    case unauthorized
    case emptyErrorWithStatusCode(String)
}
