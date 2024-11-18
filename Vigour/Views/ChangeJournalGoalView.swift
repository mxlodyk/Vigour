//  ChangeJournalGoalView.swift
//  Vigour
//  Created by Melody Flavel on 17/11/2024.

import SwiftUI

struct ChangeJournalGoalView: View {
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var journalGoal: Int16
    @State var journalGoalText: String = ""
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("", text: $journalGoalText, prompt: Text("Minutes").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                
                Button(action: {
                    saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Change Journal Goal")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }
    
    // MARK: Save Button Pressed
    func saveButtonPressed() {
        journalGoal = Int16(journalGoalText) ?? 0
        edp.saveJournalGoal(journalGoal)
    }
}


