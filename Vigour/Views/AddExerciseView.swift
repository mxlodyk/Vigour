//  AddExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct AddExerciseView: View {
    
    @Binding var program: ProgramModel
    var workout: WorkoutModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var exerciseViewModel = ExerciseViewModel()
    
    @State var newExerciseName: String = ""
    @State var newExerciseSets: String = ""
    @State var newExerciseWeight: String = ""
    @State var newExerciseRepetitions: String = ""
    @State var newExerciseRest: String = ""
    
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
                HStack {
                    let options = ["KG", "LB"]
                    TextField("", text: $newExerciseWeight, prompt: Text("Weight").foregroundColor(textFieldTextColour))
                        .withDetailFieldFormatting()
                    DropDownList(options: options)
                }
                HStack {
                    let options = ["Min", "Sec"]
                    TextField("", text: $newExerciseRest, prompt: Text("Rest").foregroundColor(textFieldTextColour))
                        .withDetailFieldFormatting()
                    DropDownList(options: options)
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
    
    func saveButtonPressed() {
        let newExercise = ExerciseModel(name: newExerciseName, sets: newExerciseSets, weight: newExerciseWeight, repetitions: newExerciseRepetitions, rest: newExerciseRest)
        exerciseViewModel.addExercise(program.id, workout.id, newExercise)
    }
}
