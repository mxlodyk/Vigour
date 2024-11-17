//  AddWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Add Workout View
struct AddWorkoutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    //@ObservedObject var edp = ExerciseDataProvider()
    @EnvironmentObject var edp: ExerciseDataProvider
    @Binding var program: ProgramEntity
    @State var newWorkoutName: String = ""
        
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
        
        // MARK: Save Button Pressed
        func saveButtonPressed() {
            guard !newWorkoutName.isEmpty else { return }
            edp.addWorkout(program, newWorkoutName)
            newWorkoutName = ""
    }
}

