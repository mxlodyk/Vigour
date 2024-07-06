//  AddExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct AddExerciseView: View {
    
    @Binding var program: ProgramModel
    var workout: WorkoutModel
    @Environment(\.presentationMode) var presentationMode
    
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
                TextField("Exercise Name", text: $newExerciseName)
                    .withTextFieldFormatting()
                TextField("Sets", text: $newExerciseSets)
                    .withTextFieldFormatting()
                TextField("Weight", text: $newExerciseWeight)
                    .withTextFieldFormatting()
                TextField("Repetitions", text: $newExerciseRepetitions)
                    .withTextFieldFormatting()
                TextField("Rest", text: $newExerciseRest)
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
    
    func saveButtonPressed() {
        //let workoutID = workout.id
        @State var newExercise = ExerciseModel(name: newExerciseName, sets: newExerciseSets, weight: newExerciseWeight, repetitions: newExerciseRepetitions, rest: newExerciseRest)
        DataProvider.addExercise(programID: program.id, workoutID: workout.id, exerciseModel: newExercise)
    }
}
