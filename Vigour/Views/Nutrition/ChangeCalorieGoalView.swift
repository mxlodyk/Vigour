//  ChangeCalorieGoalView.swift
//  Vigour
//  Created by Melody Flavel on 17/11/2024.

import SwiftUI

struct ChangeCalorieGoalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @Binding var calorieGoal: Int16
    @State var calorieGoalText: String = ""
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $calorieGoalText, prompt: Text("Calorie Goal").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                
                Button(action: {
                    saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Change Calorie Goal")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }
    
    // MARK: Save Button Pressed
    func saveButtonPressed() {
        calorieGoal = Int16(calorieGoalText) ?? 0
        edp.saveCalorieGoal(calorieGoal)
    }
}
