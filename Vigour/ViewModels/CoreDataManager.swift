//  CoreDataManager.swift
//  Vigour
//  Created by Melody Flavel on 18/11/2024.

import Foundation
import CoreData

// MARK: Core Data Manager
class CoreDataManager {
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    // MARK: Singleton
    static let instance = CoreDataManager()
    
    
    public init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = container.viewContext
    }
    
    // MARK: Initialise
    init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    // MARK: Save
    func save() {
        do {
            try context.save()
            print("Saved Core Data successfully.")
        } catch let error {
            print("Error saving Core Data: \(error.localizedDescription)")
        }
    }
} // End of CoreDataManager class.
