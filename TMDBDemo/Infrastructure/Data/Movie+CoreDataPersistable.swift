//
//  Message+CoreDataPersistable.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import Foundation
import CoreData

extension Movie: CoreDataPersistable {
    typealias ManagedType = FavoriteMovieEntity

    init?(managedObject: FavoriteMovieEntity) {
        let moId = managedObject.id
        let moRating = managedObject.rating
        
        guard let moName = managedObject.name,
              let moPoster = managedObject.poster,
              let moDescription = managedObject.desc else {
            return nil
        }
        self.id = Int(moId)
        self.name = moName
        self.poster = moPoster
        self.genres = []
        self.rating = moRating
        self.description = moDescription
    }
    
    func toManagedObject(context: NSManagedObjectContext) async -> ManagedType {
        let persistedValue = ManagedType.init(context: context)
        
        persistedValue.id = Int32(self.id)
        persistedValue.name = self.name
        persistedValue.poster = self.poster
        persistedValue.rating = self.rating
        persistedValue.desc = self.description
        
        return persistedValue
    }
}
