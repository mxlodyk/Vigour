//  ExerciseModel.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import Foundation

struct ExerciseModel: Identifiable {
    internal let id: UUID = UUID()
    internal var name: String
    internal var sets: Int
    internal var weight: Float
    internal var repetitions: Int
    internal var rest: Int
    internal var restUnit: String
}
