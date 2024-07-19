//  HealthManager.swift
//  Vigour
//  Created by Melody Flavel on 16/7/2024.

import Foundation
import HealthKit

extension HKWorkout {
    var workoutName: String {
        switch self.workoutActivityType {
        case .functionalStrengthTraining: return "Functional Strength Training"
        case .traditionalStrengthTraining: return "Traditional Strength Training"
        default: return "Other"
        }
    }
}

// MARK: Health Manager
class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var currentWeek: [Date] = []
    @Published var selectedDay: Date = Date()
    
    @Published var dailySteps: Double = 0.0
    @Published var syncedWorkouts: [HKWorkout] = []
    
    init() {

        let steps = HKQuantityType(.stepCount)
        let workouts = HKObjectType.workoutType()
        let healthTypes: Set = [steps, workouts]
        
        // MARK: Request Authorisation to Read Health Data
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("Error requesting authorisation to read health data.")
            }
        }
    }
    
    // MARK: Fetch Step Count
    func fetchSelectedDaySteps() {
        
        let steps = HKQuantityType(.stepCount)
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDay)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay)
        
        // MARK: HealthKit Query
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate, options: .cumulativeSum) {_, result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.dailySteps = 0
                }
                            print("Error fetching today's step data: \(error.localizedDescription)")
                            return
                        }
                        guard let quantity = result?.sumQuantity() else {
                            print("No step data available for today.")
                            return
                        }
                        let stepCount = quantity.doubleValue(for: .count())
                        DispatchQueue.main.async {
                            self.dailySteps = stepCount
                        }
        }
        healthStore.execute(query)
    }
    
    // MARK: Fetch Workouts
    func fetchSelectedDayWorkouts() {
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDay)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay)
        
        let query = HKSampleQuery(sampleType: HKObjectType.workoutType(), predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (_, samples, error) in
            if let error = error {
                print("Error fetching workouts: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.syncedWorkouts = samples as? [HKWorkout] ?? []
            }
        }
        healthStore.execute(query)
    }
    
    // MARK: Fetch Current Week
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        guard let week = calendar.dateInterval(of: .weekOfMonth, for: today),
            let firstWeekDay = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today) else {
                return
        }
        currentWeek = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: firstWeekDay) }
    }
    
    // MARK: Extract Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // MARK: Check Current Date
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, inSameDayAs: selectedDay)
    }
}
