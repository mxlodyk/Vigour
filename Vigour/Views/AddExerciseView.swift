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
    @State var newExerciseSets: Int = 0
    @State var newExerciseWeight: Float = 0
    @State var newExerciseRepetitions: Int = 0
    @State var newExerciseRest: Int = 0
    @State var newExerciseRestUnit: String = ""
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $newExerciseName, prompt: Text("Exercise Name").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                HStack {
                    TextField("", text: Binding<String>(
                        get: { String(newExerciseSets)},
                        set: { newExerciseSets = Int($0) ?? 0}
                    ))
                    .withDetailFieldFormatting()
                    TextField("", text: Binding<String>(
                        get: { String(newExerciseRepetitions)},
                        set: { newExerciseRepetitions = Int($0) ?? 0}
                    ))
                }
                HStack {
                    TextField("", text: Binding<String>(
                        get: { String(newExerciseWeight)},
                        set: { newExerciseWeight = Float($0) ?? 0}
                    ))
                }
                HStack {
                    TextField("", text: Binding<String>(
                        get: { String(newExerciseRest)},
                        set: { newExerciseRest = Int($0) ?? 0}
                    ))
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
