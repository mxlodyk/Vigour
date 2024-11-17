//  CoreDataManager.swift
//  Vigour
//  Created by Melody Flavel on 18/11/2024.

import Foundation
import CoreData

// MARK: Core Data Manager
class CoreDataManager {
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    // Singleton
    static let instance = CoreDataManager()
    
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
}
