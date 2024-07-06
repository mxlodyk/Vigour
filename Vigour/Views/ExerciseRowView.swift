//  ExerciseRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct ExerciseRowView: View {
    
    @State var exercise: ExerciseModel
    
    var body: some View {
        NavigationLink(destination: ExerciseView()){
            Text(exercise.name)
                .withButtonFormatting()
        }
    }
}
