//  CoreData.swift
//  Vigour
//  Created by Melody Flavel on 9/7/2024.

import Foundation
import CoreData

class CoreData: ObservableObject {
    
    let container: NSPersistentContainer
    
    init () {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data. \(error)")
            }
        }
    }
}
