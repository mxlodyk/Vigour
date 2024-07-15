//  WorkoutListRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Workout Row View
struct WorkoutRowView: View {
    
    @Binding var program: ProgramEntity
    @State var workout: WorkoutEntity
    
    var body: some View {
        
        NavigationLink(destination: ExercisesView(program: $program, workout: $workout)){
            Text(workout.name ?? "")
                .withButtonFormatting()
        }
    }
}
