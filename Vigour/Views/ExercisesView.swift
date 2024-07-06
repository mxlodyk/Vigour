//  ExercisesView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct ExercisesView: View {
    
    @Binding var workout: WorkoutModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(workout.exercises) { exercise in
                        ExerciseRowView(exercise: exercise)
                    }
                }
                .withEdgePadding()
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("BackArrow")
                        .iconStyle()
                })
        }
    }
}
