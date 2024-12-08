//  NutritionDataProvider.swift
//  Vigour
//  Created by Melody Flavel on 18/11/2024.

import Foundation
import CoreData

class NutritionDataProvider: ObservableObject {
    
    let shared = CoreDataManager.instance
    private var calendarDataProvider: CalendarDataProvider
    
    @Published var loggedFood: [FoodLogEntity] = []
    
    // MARK: Initialise
    init(calendarDataProvider: CalendarDataProvider) {
        self.calendarDataProvider = calendarDataProvider
        getLoggedFoodForSelectedDay()
    }
    
    // MARK: Log Food
    func logFood(_ food: FoodEntity) {
            
        let newLog = FoodLogEntity(context: shared.context)
        newLog.date = calendarDataProvider.selectedDay
        newLog.food = food
            
            do {
                try shared.context.save()
                getLoggedFoodForSelectedDay()
            } catch {
                // Handle the Core Data error appropriately
                print("Failed to save log: \(error.localizedDescription)")
            }
        }
    
    // MARK: Get Logged Workouts for Current Day
    func getLoggedFoodForSelectedDay() {
        let request = NSFetchRequest<FoodLogEntity>(entityName: "FoodLogEntity")
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: calendarDataProvider.selectedDay)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            loggedFood = try shared.context.fetch(request)
        } catch let error {
            print("Error fetching logged workouts: \(error.localizedDescription)")
            loggedFood = []
        }
    }
    
    // MARK: Save
    func save() {
        getLoggedFoodForSelectedDay()
    }
}
