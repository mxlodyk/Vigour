//  AddSetView.swift
//  Vigour
//  Created by Melody Flavel on 19/7/2024.

import SwiftUI

struct AddSetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var cd = CoreDataProvider()
    
    var exercise: ExerciseEntity
    @State var newWeight: String = ""
    @State var newRepetitions: String = ""
    @State var newTempo: String = ""
    @State var newRestTime: String = ""
    @State var newRestUnit: String = "Min"
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $newWeight, prompt: Text("Weight").foregroundColor(textFieldTextColour))
                .withDetailFieldFormatting()
                TextField("", text: $newRepetitions, prompt: Text("Repetitions").foregroundColor(textFieldTextColour))
                .withDetailFieldFormatting()
                TextField("", text: $newTempo, prompt: Text("Tempo").foregroundColor(textFieldTextColour))
                .withDetailFieldFormatting()
                TextField("", text: $newRestTime, prompt: Text("Rest").foregroundColor(textFieldTextColour))
                .withDetailFieldFormatting()
                RestUnitView(newExerciseRestUnit: $newRestUnit)
                Button(action: {
                    saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Set")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
        }
    }
    
    // MARK: Save Button Pressed
    func saveButtonPressed() {
        cd.addSet(exercise, newWeight, newRepetitions, newTempo, newRestTime, newRestUnit)
    }
}
