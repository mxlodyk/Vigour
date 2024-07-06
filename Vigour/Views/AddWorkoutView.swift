//  AddWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct AddWorkoutView: View {
    
    @Binding var program: ProgramModel
    @State var newWorkoutName: String = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var workoutViewModel = WorkoutViewModel()
        
        var body: some View {
            
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    TextField("", text: $newWorkoutName, prompt: Text("Workout Name").foregroundColor(textFieldTextColour))
                        .withTextFieldFormatting()
                    Button(action: {
                        saveButtonPressed()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Workout")
                            .withButtonFormatting()
                    }
                }
                .withEdgePadding()
                .padding(.top, 30)
            }
        }
        
        func saveButtonPressed() {
            let newWorkout = WorkoutModel(name: newWorkoutName, exercises: [])
            workoutViewModel.addWorkout(program.id, newWorkout)
    }
}

