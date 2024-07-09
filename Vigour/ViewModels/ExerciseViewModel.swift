//  ExerciseViewModel.swift
//  Vigour
//  Created by Melody Flavel on 7/7/2024.

import Foundation

class ExerciseViewModel: ObservableObject {
    
    @Published var programs: [ProgramModel] = []
    
    init() {
        self.programs = DataProvider.getPrograms()
    }
    
    // Add Exercise
    func addExercise(_ programID: UUID, _ workoutID: UUID, _ exercise: ExerciseModel) {
        if let programIndex = programs.firstIndex(where: { $0.id == programID }) {
            if let workoutIndex = programs[programIndex].workouts.firstIndex(where: { $0.id == workoutID }) {
                programs[programIndex].workouts[workoutIndex].exercises.append(exercise)
                DataProvider.addExercise(programID: programID, workoutID: workoutID, exerciseModel: exercise)
            } else {
                print("Program with ID \(programID) not found.")
            }
        }
    }
    
    // Delete Exercise
    func deleteExercise(_ programID: UUID, _ workoutID: UUID, _ exercise: ExerciseModel) {
        if let programIndex = programs.firstIndex(where: { $0.id == programID}) {
            if let workoutIndex = programs[programIndex].workouts.firstIndex(where: { $0.id == workoutID}) {
                if let exerciseIndex = programs[programIndex].workouts[workoutIndex].exercises.firstIndex(where: { $0.id == exercise.id}) {
                    programs[programIndex].workouts[workoutIndex].exercises.remove(at: exerciseIndex)
                    DataProvider.deleteExercise(programID, workoutID, exercise)
                }
            }
        }
    }
    
}
