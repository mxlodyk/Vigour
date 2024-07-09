//  ProgramModel.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import Foundation

struct ProgramModel: Identifiable {
    internal let id: UUID = UUID()
    internal var name: String
    internal var workouts: [WorkoutModel]
}
