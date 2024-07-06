//  WorkoutListRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct WorkoutRowView: View {
    
    @Binding var program: ProgramModel
    @State var workout: WorkoutModel
    
    var body: some View {
        
        NavigationLink(destination: ExercisesView(program: $program, workout: $workout)){
            Text(workout.name)
                .withButtonFormatting()
        }
    }
}
