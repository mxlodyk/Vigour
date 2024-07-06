//  DataProvider.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import Foundation

class DataProvider: ObservableObject {
    
    static var programs: [ProgramModel] = []
    
    static func getPrograms() -> [ProgramModel] {
        
        if programs.isEmpty {
            
            var program1 = ProgramModel(name: "Melody's Program", workouts: [])
            program1.workouts = [
                WorkoutModel(name: "Glutes", exercises: []),
                WorkoutModel(name: "Hamstrings", exercises: []),
                WorkoutModel(name: "Quadriceps", exercises: [])
            ]
            program1.workouts[0].exercises = [
                ExerciseModel(name: "Hip Thrust", sets: "4", weight: "140", repetitions: "12", rest: "120"),
                ExerciseModel(name: "Cable Kickback", sets: "4", weight: "20", repetitions: "12", rest: "90")
            ]
            program1.workouts[1].exercises = [
                ExerciseModel(name: "Hamstring Curl", sets: "4", weight: "60", repetitions: "12", rest: "90"),
                ExerciseModel(name: "Romanian Deadlift", sets: "4", weight: "60", repetitions: "12", rest: "90")
            ]
            program1.workouts[2].exercises = [
                ExerciseModel(name: "Bulgarian Split Squat", sets: "4", weight: "60", repetitions: "12", rest: "90"),
                ExerciseModel(name: "Leg Extension", sets: "4", weight: "60", repetitions: "12", rest: "90")
            ]
            programs.append(program1)
            
            var program2 = ProgramModel(name: "5 x 5", workouts: [])
            program2.workouts = [
                WorkoutModel(name: "Upper Body", exercises: []),
                WorkoutModel(name: "Lower Body", exercises: []),
            ]
            program2.workouts[0].exercises = [
                ExerciseModel(name: "Barbell Row", sets: "4", weight: "60", repetitions: "12", rest: "90"),
                ExerciseModel(name: "Barbell Overhead Press", sets: "4", weight: "60", repetitions: "12", rest: "90")
            ]
            program2.workouts[1].exercises = [
                ExerciseModel(name: "Barbell Back Squat", sets: "4", weight: "60", repetitions: "12", rest: "90"),
                ExerciseModel(name: "Barbell Deadlift", sets: "4", weight: "60", repetitions: "12", rest: "90")
            ]
            programs.append(program2)
        }
        
        return programs
    }
    
    // Add Program
    static func addProgram(programModel: inout ProgramModel) {
        programs.append(programModel)
    }
    
    // Add Workout
    static func addWorkout(programID: String, workoutModel: WorkoutModel) {
        if let index = programs.firstIndex(where: { $0.id == programID }) {
            programs[index].workouts.append(workoutModel)
        } else {
            print("Program with ID \(programID) not found.")
        }
    }
    
    // Add Exercise
    static func addExercise(programID: String, workoutID: String, exerciseModel: ExerciseModel) {
        if let program = programs.firstIndex(where: { $0.id == programID }) {
            if let workout = programs[program].workouts.firstIndex(where: { $0.id == workoutID }) {
                programs[program].workouts[workout].exercises.append(exerciseModel)
            } else {
                print("Program with ID \(programID) not found.")
            }
        }
    }
    
}
