//  ExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: ExerciseView
struct ExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var exercise: ExerciseEntity
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Exercise: \(exercise.name ?? "")\nSets: \(exercise.sets ?? "")\nRepetitions: \(exercise.repetitions ?? "")\nWeight: \(exercise.weight ?? "")\nRest: \(exercise.rest ?? "") \(exercise.restUnit ?? "Min")")
                    .withTextFormatting()
                    .foregroundColor(themeColour)
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("BackButton")
                        .iconStyle()
                })
        }
    }
}
