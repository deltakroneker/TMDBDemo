//
//  CoreDataPersistable.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import CoreData

protocol CoreDataPersistable {
    associatedtype ManagedType
    
    init?(managedObject: ManagedType)
        
    func toManagedObject(context: NSManagedObjectContext) async -> ManagedType
    func save(context: NSManagedObjectContext) throws
}

extension CoreDataPersistable where ManagedType: NSManagedObject {
    func save(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) throws {
        try context.save()
    }
}
