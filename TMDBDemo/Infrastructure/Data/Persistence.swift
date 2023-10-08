//
//  Persistence.swift
//  TMDBDemo
//
//  Created by nikolamilic on 10/8/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TMDBDemo")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    static func save() {
        let context = PersistenceController.shared.container.viewContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
//            print("PersistenceController: Context saved successfully! 🟢")
        } catch {
            fatalError("""
                \(#file), \
                \(#function), \
                \(error.localizedDescription)
              """)
        }
    }
}
