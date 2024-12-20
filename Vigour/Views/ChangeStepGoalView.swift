//  ChangeStepGoalView.swift
//  Vigour
//  Created by Melody Flavel on 17/7/2024.

import SwiftUI

struct ChangeStepGoalView: View {
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var stepGoal: Int32
    @State var stepGoalText: String = ""
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $stepGoalText, prompt: Text("Step Goal").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                
                Button(action: {
                    saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Change Step Goal")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }
    
    // MARK: Save Button Pressed
    func saveButtonPressed() {
        stepGoal = Int32(stepGoalText) ?? 0
        edp.saveStepGoal(stepGoal)
    }
}
