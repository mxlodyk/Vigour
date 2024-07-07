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
    @State var newExerciseRestUnit: String = "Min"
    
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
                    TextField("", text: $newExerciseWeight, prompt: Text("Weight").foregroundColor(textFieldTextColour))
                        .withDetailFieldFormatting()
                }
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
    
    func saveButtonPressed() {
        let newExercise = ExerciseModel(name: newExerciseName, sets: newExerciseSets, weight: newExerciseWeight, repetitions: newExerciseRepetitions, rest: newExerciseRest, restUnit: newExerciseRestUnit)
        exerciseViewModel.addExercise(program.id, workout.id, newExercise)
    }
}
