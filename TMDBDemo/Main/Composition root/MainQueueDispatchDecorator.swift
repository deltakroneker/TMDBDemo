//
//  MainQueueDispatchDecorator.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/6/23.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    let decoratee: T
    
    init(_ decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}
