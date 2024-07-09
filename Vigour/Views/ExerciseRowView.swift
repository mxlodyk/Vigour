//  ExerciseRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// Exercise Row View
struct ExerciseRowView: View {
    
    @State var exercise: ExerciseEntity
    
    var body: some View {
        NavigationLink(destination: ExerciseView(exercise: $exercise)){
            Text(exercise.name ?? "")
                .withButtonFormatting()
        }
    }
}
