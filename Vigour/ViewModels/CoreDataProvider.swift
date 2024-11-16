//  CoreDataProvider.swift
//  Vigour
//  Created by Melody Flavel on 9/7/2024.

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
        // The attribute types of CoreDataStringContainer are strings to support TextField modifiers in AddExerciseView
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
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

// MARK: Core Data Provider
class CoreDataProvider: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var currentWeek: [Date] = []
    @Published var selectedDay: Date = Date()
    
    @Published var programs: [ProgramEntity] = []
    @Published var workouts: [WorkoutEntity] = []
    @Published var exercises: [ExerciseEntity] = []
    @Published var sets: [SetEntity] = []
    @Published var loggedWorkouts: [WorkoutLogEntity] = []
    @Published var loggedFood: [FoodLogEntity] = []
    
    // MARK: Initialise
    init() {
        getPrograms()
        getWorkouts()
        getExercises()
        getSets()
        fetchCurrentWeek()
        getLoggedWorkoutsForSelectedDay()
        getLoggedFoodForSelectedDay() // NEW
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
    
    // MARK: Log Workout
    func logWorkout(_ workout: WorkoutEntity) {
            
        let newLog = WorkoutLogEntity(context: manager.context)
            newLog.date = selectedDay
            newLog.workout = workout
            
            do {
                try manager.context.save()
                getLoggedWorkoutsForSelectedDay()
            } catch {
                // Handle the Core Data error appropriately
                print("Failed to save log: \(error.localizedDescription)")
            }
        }
    
    // MARK: Log Food
    func logFood(_ food: FoodEntity) {
            
        let newLog = FoodLogEntity(context: manager.context)
            newLog.date = selectedDay
            newLog.food = food
            
            do {
                try manager.context.save()
                getLoggedFoodForSelectedDay()
            } catch {
                // Handle the Core Data error appropriately
                print("Failed to save log: \(error.localizedDescription)")
            }
        }
    
    // MARK: Delete Logged Workout
    func deleteLoggedWorkout(_ workoutLog: WorkoutLogEntity) {
        manager.context.delete(workoutLog)
        save()
    }
    
    // MARK: Get Logged Workouts for Current Day
    func getLoggedWorkoutsForSelectedDay() {
        let request = NSFetchRequest<WorkoutLogEntity>(entityName: "WorkoutLogEntity")
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDay)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            loggedWorkouts = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching logged workouts: \(error.localizedDescription)")
            loggedWorkouts = []
        }
    }
    
    // MARK: Get Logged Workouts for Current Day
    func getLoggedFoodForSelectedDay() {
        let request = NSFetchRequest<FoodLogEntity>(entityName: "FoodLogEntity")
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDay)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            loggedFood = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching logged workouts: \(error.localizedDescription)")
            loggedFood = []
        }
    }
    
    // MARK: Get Programs
    func getPrograms() {
        let request = NSFetchRequest<ProgramEntity>(entityName: "ProgramEntity")
        do {
            programs = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Program
    func addProgram(_ newProgramName: String) {
        let newProgram = ProgramEntity(context: manager.context)
        newProgram.id = UUID()
        newProgram.name = newProgramName
        save()
    }
    
    // MARK: Delete Program
    func deleteProgram(_ program: ProgramEntity) {
        manager.context.delete(program)
        save()
    }
    
    // MARK: Get Workouts
    func getWorkouts() {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        do {
            workouts = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Workout
    func addWorkout(_ program: ProgramEntity, _ newWorkoutName: String) {
        let newWorkout = WorkoutEntity(context: manager.context)
        newWorkout.id = UUID()
        newWorkout.name = newWorkoutName
        newWorkout.addToPrograms(program)
        save()
    }
    
    // MARK: Delete Workout
    func deleteWorkout(_ workout: WorkoutEntity, _ program: ProgramEntity) {
        workout.removeFromPrograms(program)
        save()
    }
    
    // MARK: Get Exercises
    func getExercises() {
        let request = NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
        do {
            exercises = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Exercise
    func addExercise(_ program: ProgramEntity, _ workout: WorkoutEntity, _ newExerciseName: String) {
        let newExercise = ExerciseEntity(context: manager.context)
        newExercise.id = UUID()
        newExercise.name = newExerciseName
        newExercise.addToWorkouts(workout)
        save()
    }
    
    // MARK: Get Sets
    func getSets() {
        let request = NSFetchRequest<SetEntity>(entityName: "SetEntity")
        do {
            sets = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Set
    func addSet(_ exercise: ExerciseEntity, _ weight: String, _ repetitions: String, _ tempo: String, _ restTime: String, _ restUnit: String) {
        let newSet = SetEntity(context: manager.context)
        newSet.id = UUID()
        newSet.weight = weight
        newSet.repetitions = repetitions
        newSet.tempo = tempo
        newSet.restTime = restTime
        newSet.restUnit = restUnit
        newSet.addToExercise(exercise)
        save()
    }
    
    func deleteSet(_ set: SetEntity, _ exercise: ExerciseEntity) {
        set.removeFromExercise(exercise)
        save()
    }
    
    // MARK: Delete Exercise
    func deleteExercise(_ exercise: ExerciseEntity, _ workout: WorkoutEntity) {
        exercise.removeFromWorkouts(workout)
        save()
    }
    
    // MARK: Save
    func save() {
        manager.save()
        getPrograms()
        getWorkouts()
        getExercises()
        getSets()
        getLoggedWorkoutsForSelectedDay()
        getLoggedFoodForSelectedDay() // NEW
    }
    
}
