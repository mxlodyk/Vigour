//  ExerciseViewModel.swift
//  Vigour
//  Created by Melody Flavel on 7/7/2024.

import Foundation

class ExerciseViewModel: ObservableObject {
    
    @Published var programs: [ProgramModel] = []
    
    init() {
        self.programs = DataProvider.getPrograms()
    }
    
    func addExercise(_ programID: String, _ workoutID: String, _ exercise: ExerciseModel) {
        if let programIndex = programs.firstIndex(where: { $0.id == programID }) {
            if let workoutIndex = programs[programIndex].workouts.firstIndex(where: { $0.id == workoutID }) {
                programs[programIndex].workouts[workoutIndex].exercises.append(exercise)
                DataProvider.addExercise(programID: programID, workoutID: workoutID, exerciseModel: exercise)
            } else {
                print("Program with ID \(programID) not found.")
            }
        }
    }
}
