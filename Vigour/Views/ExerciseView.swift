//  ExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct ExerciseView: View {
    
    @Binding var exercise: ExerciseModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Exercise: \(exercise.name)\nSets: \(exercise.sets)\nWeight: \(formattedWeight)\nRepetitions: \(exercise.repetitions)\nRest: \(exercise.rest) \(exercise.restUnit)")
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
    
    private var formattedWeight: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: exercise.weight)) ?? "\(exercise.weight)"
    }
}
