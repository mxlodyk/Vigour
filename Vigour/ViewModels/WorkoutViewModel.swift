//  WorkoutViewModel.swift
//  Vigour
//  Created by Melody Flavel on 7/7/2024.

import Foundation

class WorkoutViewModel: ObservableObject {
    
    @Published var programs: [ProgramModel] = []
    
    init() {
        self.programs = DataProvider.getPrograms()
    }
    
    // Add Workout
    func addWorkout(_ programID: UUID, _ workout: WorkoutModel) {
        if let index = programs.firstIndex(where: { $0.id == programID }) {
            programs[index].workouts.append(workout)
            DataProvider.addWorkout(programID: programID, workoutModel: workout)
        } else {
            print("Program with ID \(programID) not found.")
        }
    }
    
    // Delete Workout
    func deleteWorkout(programID: UUID, workout: WorkoutModel) {
        if let programIndex = programs.firstIndex(where: { $0.id == programID}) {
            if let workoutIndex = programs[programIndex].workouts.firstIndex(where: { $0.id == workout.id}) {
                programs[programIndex].workouts.remove(at: workoutIndex)
                DataProvider.deleteWorkout(programID: programID, workout: workout)
            }
        }
    }
    
}
