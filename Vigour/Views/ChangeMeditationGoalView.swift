//  ChangeMeditationGoalView.swift
//  Vigour
//  Created by Melody Flavel on 17/11/2024.

import SwiftUI

struct ChangeMeditationGoalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var meditationGoal: Int16
    @State var meditationGoalText: String = ""
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $meditationGoalText, prompt: Text("Minutes").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                
                Button(action: {
                    saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Change Meditation Goal")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }
    
    // MARK: Save Button Pressed
    func saveButtonPressed() {
        meditationGoal = Int16(meditationGoalText) ?? 0
        ExerciseDataProvider().saveMeditationGoal(meditationGoal)
    }
}

