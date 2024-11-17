//  AddExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Add Exercise View
struct AddExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    //@ObservedObject var edp = ExerciseDataProvider()
    @EnvironmentObject var edp: ExerciseDataProvider
    @Binding var program: ProgramEntity
    @Binding var workout: WorkoutEntity
    
    @State var newExerciseName: String = ""
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $newExerciseName, prompt: Text("Exercise Name").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                Button(action: {
                    saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Exercise")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }
    
    // MARK: Save Button Pressed
    func saveButtonPressed() {
        guard !newExerciseName.isEmpty else { return }
        edp.addExercise(program, workout, newExerciseName)
        newExerciseName = ""
    }
}
