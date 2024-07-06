//  WorkoutListRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct WorkoutRowView: View {
    
    @State var workout: WorkoutModel
    
    var body: some View {
        
        NavigationLink(destination: ExercisesView()){
            Text(workout.name)
                .withButtonFormatting()
        }
    }
}
