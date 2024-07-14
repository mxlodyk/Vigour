//  HealthManager.swift
//  Vigour
//  Created by Melody Flavel on 12/7/2024.

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init() {
        
        let steps = HKQuantityType(.stepCount)
        let healthTypes: Set = [steps]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            }
            catch {
                print("Error fetching steps data. \(error)")
            }
        }
    }
}
