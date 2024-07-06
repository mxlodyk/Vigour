//  WorkoutViewModel.swift
//  Vigour
//  Created by Melody Flavel on 7/7/2024.

import Foundation

class WorkoutViewModel: ObservableObject {
    
    @Published var programs: [ProgramModel] = []
    
    init() {
        self.programs = DataProvider.getPrograms()
    }
    
    func addWorkout(_ programID: String, _ workout: WorkoutModel) {
        if let index = programs.firstIndex(where: { $0.id == programID }) {
            programs[index].workouts.append(workout)
            DataProvider.addWorkout(programID: programID, workoutModel: workout)
        } else {
            print("Program with ID \(programID) not found.")
        }
    }
    
}
