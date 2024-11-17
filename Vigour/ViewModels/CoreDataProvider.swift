//  CoreDataProvider.swift
//  Vigour
//  Created by Melody Flavel on 9/7/2024.

import Foundation
import CoreData

// MARK: REFACTOR TO CALENDARDATAPROVIDER, NUTRITIONDATAPROVIDER, EXERCISEDATAPROVIDER, MENTALHEALTHDATAPROVIDER

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
        getLoggedFoodForSelectedDay()
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
    
    // MARK: Save User Measurement System
    func saveMeasurementSystem(_ system: MeasurementSystem) {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let users = try manager.context.fetch(fetchRequest)
            let user = users.first ?? UserEntity(context: manager.context)
            
            user.measurementSystem = system.rawValue
            
            try manager.context.save()
            print("User's system saved as \(user.measurementSystem)")
        }
        catch {
            print("Failed to save measurement system: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Measurement System
    func getMeasurementSystem() -> MeasurementSystem {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            if let user = try manager.context.fetch(fetchRequest).first,
               let preferredSystem = MeasurementSystem(rawValue: user.measurementSystem ?? "") {
                return preferredSystem
            }
        } catch {
            print("Failed to fetch measurement system: \(error.localizedDescription)")
        }
        return .metric // Default system
    }
    
    // MARK: REFACTOR GOAL SETTERS ANG GETTERS
    
    // MARK: Save User Step Goal
    func saveStepGoal(_ stepGoal: Int32) {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        do {
            let goals = try manager.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: manager.context)
            
            goal.steps = stepGoal
            
            try manager.context.save()
            print("User's step goal saved as \(goal.steps)")
        } catch {
            print("Failed to save step goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Step Goal
    func getStepGoal() -> Int32 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try manager.context.fetch(fetchRequest).first {
                return goal.steps ?? 2000
            }
        } catch {
            print("Failed to fetch user step goal: \(error.localizedDescription)")
        }
        return 2000 // Default step goal
    }
    
    // MARK: Save User Calorie Goal
    func saveCalorieGoal(_ calorieGoal: Int16) {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        do {
            let goals = try manager.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: manager.context)
            
            goal.calories = calorieGoal
            
            try manager.context.save()
            print("User's calorie goal saved as \(goal.calories)")
        } catch {
            print("Failed to save calorie goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Calorie Goal
    func getCalorieGoal() -> Int16 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try manager.context.fetch(fetchRequest).first {
                return goal.calories ?? 3000
            }
        } catch {
            print("Failed to fetch user calorie goal: \(error.localizedDescription)")
        }
        return 3000 // Default calorie goal
    }
    
    // MARK: Save User Meditation Goal
    func saveMeditationGoal(_ meditationGoal: Int16) {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        do {
            let goals = try manager.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: manager.context)
            
            goal.meditation = meditationGoal
            
            try manager.context.save()
            print("User's meditation goal saved as \(goal.meditation)")
        } catch {
            print("Failed to save meditation goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Meditation Goal
    func getMeditationGoal() -> Int16 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try manager.context.fetch(fetchRequest).first {
                return goal.meditation != 0 ? goal.meditation : 10
            }
        } catch {
            print("Failed to fetch user meditation goal: \(error.localizedDescription)")
        }
        return 10 // Default meditation goal
    }
    
    // MARK: Save User Journal Goal
    func saveJournalGoal(_ journalGoal: Int16) {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        do {
            let goals = try manager.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: manager.context)
            
            goal.journal = journalGoal
            
            try manager.context.save()
            print("User's journal goal saved as \(goal.journal)")
        } catch {
            print("Failed to save journal goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Journal Goal
    func getJournalGoal() -> Int16 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try manager.context.fetch(fetchRequest).first {
                return goal.journal != 0 ? goal.journal : 15
            }
        } catch {
            print("Failed to fetch user journal goal: \(error.localizedDescription)")
        }
        return 15 // Default journal goal
    }
    
    // MARK: Save
    func save() {
        manager.save()
        getPrograms()
        getWorkouts()
        getExercises()
        getSets()
        getLoggedWorkoutsForSelectedDay()
        getLoggedFoodForSelectedDay()
    }
}
