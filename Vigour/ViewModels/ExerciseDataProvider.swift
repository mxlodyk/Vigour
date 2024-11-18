//  ExerciseDataProvider.swift
//  Vigour
//  Created by Melody Flavel on 9/7/2024.

import Foundation
import CoreData

// MARK: REFACTOR TO CALENDARDATAPROVIDER, NUTRITIONDATAPROVIDER, EXERCISEDATAPROVIDER, MENTALHEALTHDATAPROVIDER

// MARK: Exercise Data Provider
class ExerciseDataProvider: ObservableObject {
    
    let shared = CoreDataManager.instance
    private var calendarDataProvider: CalendarDataProvider
    
    @Published var programs: [ProgramEntity] = []
    @Published var workouts: [WorkoutEntity] = []
    @Published var exercises: [ExerciseEntity] = []
    @Published var sets: [SetEntity] = []
    @Published var loggedWorkouts: [WorkoutLogEntity] = []
    @Published var loggedFood: [FoodLogEntity] = []
        
    // MARK: Initialise
    init(calendarDataProvider: CalendarDataProvider) {
        self.calendarDataProvider = calendarDataProvider
        getPrograms()
        getWorkouts()
        getExercises()
        getSets()
        getLoggedWorkoutsForSelectedDay()
        getLoggedFoodForSelectedDay()
    }
    
    // MARK: Log Workout
    func logWorkout(_ workout: WorkoutEntity) {
            
        let newLog = WorkoutLogEntity(context: shared.context)
        newLog.date = calendarDataProvider.selectedDay
            newLog.workout = workout
            
            do {
                try shared.context.save()
                getLoggedWorkoutsForSelectedDay()
            } catch {
                // Handle the Core Data error appropriately
                print("Failed to save log: \(error.localizedDescription)")
            }
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
    
    // MARK: Delete Logged Workout
    func deleteLoggedWorkout(_ workoutLog: WorkoutLogEntity) {
        shared.context.delete(workoutLog)
        save()
    }
    
    // MARK: Get Logged Workouts for Current Day
    func getLoggedWorkoutsForSelectedDay() {
        let request = NSFetchRequest<WorkoutLogEntity>(entityName: "WorkoutLogEntity")
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: calendarDataProvider.selectedDay)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            loggedWorkouts = try shared.context.fetch(request)
        } catch let error {
            print("Error fetching logged workouts: \(error.localizedDescription)")
            loggedWorkouts = []
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
    
    // MARK: Get Programs
    func getPrograms() {
        let request = NSFetchRequest<ProgramEntity>(entityName: "ProgramEntity")
        do {
            programs = try shared.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Program
    func addProgram(_ newProgramName: String) {
        let newProgram = ProgramEntity(context: shared.context)
        newProgram.id = UUID()
        newProgram.name = newProgramName
        save()
    }
    
    // MARK: Delete Program
    func deleteProgram(_ program: ProgramEntity) {
        shared.context.delete(program)
        save()
    }
    
    // MARK: Get Workouts
    func getWorkouts() {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        do {
            workouts = try shared.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Workout
    func addWorkout(_ program: ProgramEntity, _ newWorkoutName: String) {
        let newWorkout = WorkoutEntity(context: shared.context)
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
            exercises = try shared.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Exercise
    func addExercise(_ program: ProgramEntity, _ workout: WorkoutEntity, _ newExerciseName: String) {
        let newExercise = ExerciseEntity(context: shared.context)
        newExercise.id = UUID()
        newExercise.name = newExerciseName
        newExercise.addToWorkouts(workout)
        save()
    }
    
    // MARK: Get Sets
    func getSets() {
        let request = NSFetchRequest<SetEntity>(entityName: "SetEntity")
        do {
            sets = try shared.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // MARK: Add Set
    func addSet(_ exercise: ExerciseEntity, _ weight: String, _ repetitions: String, _ tempo: String, _ restTime: String, _ restUnit: String) {
        let newSet = SetEntity(context: shared.context)
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
            let users = try shared.context.fetch(fetchRequest)
            let user = users.first ?? UserEntity(context: shared.context)
            
            user.measurementSystem = system.rawValue
            
            try shared.context.save()
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
            if let user = try shared.context.fetch(fetchRequest).first,
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
            let goals = try shared.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: shared.context)
            
            goal.steps = stepGoal
            
            try shared.context.save()
            print("User's step goal saved as \(goal.steps)")
        } catch {
            print("Failed to save step goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Step Goal
    func getStepGoal() -> Int32 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try shared.context.fetch(fetchRequest).first {
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
            let goals = try shared.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: shared.context)
            
            goal.calories = calorieGoal
            
            try shared.context.save()
            print("User's calorie goal saved as \(goal.calories)")
        } catch {
            print("Failed to save calorie goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Calorie Goal
    func getCalorieGoal() -> Int16 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try shared.context.fetch(fetchRequest).first {
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
            let goals = try shared.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: shared.context)
            
            goal.meditation = meditationGoal
            
            try shared.context.save()
            print("User's meditation goal saved as \(goal.meditation)")
        } catch {
            print("Failed to save meditation goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Meditation Goal
    func getMeditationGoal() -> Int16 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try shared.context.fetch(fetchRequest).first {
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
            let goals = try shared.context.fetch(fetchRequest)
            let goal = goals.first ?? GoalEntity(context: shared.context)
            
            goal.journal = journalGoal
            
            try shared.context.save()
            print("User's journal goal saved as \(goal.journal)")
        } catch {
            print("Failed to save journal goal: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get User Journal Goal
    func getJournalGoal() -> Int16 {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            if let goal = try shared.context.fetch(fetchRequest).first {
                return goal.journal != 0 ? goal.journal : 15
            }
        } catch {
            print("Failed to fetch user journal goal: \(error.localizedDescription)")
        }
        return 15 // Default journal goal
    }
    
    // MARK: Save
    func save() {
        shared.save()
        getPrograms()
        getWorkouts()
        getExercises()
        getSets()
        getLoggedWorkoutsForSelectedDay()
        getLoggedFoodForSelectedDay()
    }
}
