//
//  Dispatching.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

protocol Dispatching {
    func async(execute workItem: DispatchWorkItem)
}

extension DispatchQueue: Dispatching {}
