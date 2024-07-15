//  AddExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Add Exercise View
struct AddExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var cd = CoreDataProvider()
    @Binding var program: ProgramEntity
    @Binding var workout: WorkoutEntity
    
    @State var newExerciseName: String = ""
    @State var newExerciseSets: String = ""
    @State var newExerciseWeight: String = ""
    @State var newExerciseRepetitions: String = ""
    @State var newExerciseRest: String = ""
    @State var newExerciseRestUnit: String = "Min" // Default value
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $newExerciseName, prompt: Text("Exercise Name").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                HStack {
                    TextField("", text: $newExerciseSets, prompt: Text("Sets").foregroundColor(textFieldTextColour))
                    .withDetailFieldFormatting()
                    TextField("", text: $newExerciseRepetitions, prompt: Text("Repetitions").foregroundColor(textFieldTextColour))
                    .withDetailFieldFormatting()
                }
                TextField("", text: $newExerciseWeight, prompt: Text("Weight").foregroundColor(textFieldTextColour))
                .withDetailFieldFormatting()
                HStack {
                    TextField("", text: $newExerciseRest, prompt: Text("Rest").foregroundColor(textFieldTextColour))
                    .withDetailFieldFormatting()
                    RestUnitView(newExerciseRestUnit: $newExerciseRestUnit)
                }
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
        cd.addExercise(program, workout, newExerciseName, newExerciseSets, newExerciseRepetitions, newExerciseWeight, newExerciseRest, newExerciseRestUnit)
    }
}
