//  CoreDataProvider.swift
//  Vigour
//  Created by Melody Flavel on 9/7/2024.

import Foundation
import CoreData

// Core Data Manager
class CoreDataManager {
    
    static let instance = CoreDataManager() // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    // Initialise
    init() {
        // The attribute types of CoreDataStringContainer are strings to support TextField modifiers in AddExerciseView
        container = NSPersistentContainer(name: "CoreDataStringContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    // Save
    func save() {
        do {
            try context.save()
            print("Saved Core Data successfully.")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

// Core Data Provider
class CoreDataProvider: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var programs: [ProgramEntity] = []
    @Published var workouts: [WorkoutEntity] = []
    @Published var exercises: [ExerciseEntity] = []
    
    // Initialise
    init() {
        getPrograms()
        getWorkouts()
        getExercises()
    }
    
    // Get Programs
    func getPrograms() {
        let request = NSFetchRequest<ProgramEntity>(entityName: "ProgramEntity")
        do {
            programs = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // Add Program
    func addProgram(_ newProgramName: String) {
        let newProgram = ProgramEntity(context: manager.context)
        newProgram.id = UUID()
        newProgram.name = newProgramName
        save()
    }
    
    // Delete Program
    func deleteProgram(_ program: ProgramEntity) {
        manager.context.delete(program)
        save()
    }
    
    // Get Workouts
    func getWorkouts() {
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        do {
            workouts = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // Add Workout
    func addWorkout(_ program: ProgramEntity, _ newWorkoutName: String) {
        let newWorkout = WorkoutEntity(context: manager.context)
        newWorkout.id = UUID()
        newWorkout.name = newWorkoutName
        newWorkout.addToPrograms(program)
        save()
    }
    
    // Delete Workout
    func deleteWorkout(_ workout: WorkoutEntity, _ program: ProgramEntity) {
        workout.removeFromPrograms(program)
        save()
    }
    
    // Get Exercises
    func getExercises() {
        let request = NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
        do {
            exercises = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error.localizedDescription)")
        }
    }
    
    // Add Exercise
    func addExercise(_ program: ProgramEntity, _ workout: WorkoutEntity, _ newExerciseName: String, _ newExerciseSets: String, _ newExerciseRepetitions: String, _ newExerciseWeight: String, _ newExerciseRest: String, _ newExerciseRestUnit: String) {
        let newExercise = ExerciseEntity(context: manager.context)
        newExercise.id = UUID()
        newExercise.name = newExerciseName
        newExercise.sets = newExerciseSets
        newExercise.repetitions = newExerciseRepetitions
        newExercise.weight = newExerciseWeight
        newExercise.rest = newExerciseRest
        newExercise.restUnit = newExerciseRestUnit
        newExercise.addToWorkouts(workout)
        save()
    }
    
    // Delete Exercise
    func deleteExercise(_ exercise: ExerciseEntity, _ workout: WorkoutEntity) {
        exercise.removeFromWorkouts(workout)
        save()
    }
    
    // Save
    func save() {
        manager.save()
        getPrograms()
        getWorkouts()
        getExercises()
    }
}
