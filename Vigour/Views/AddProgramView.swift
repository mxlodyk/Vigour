//  AddProgramView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Add Program View
struct AddProgramView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var cd = CoreDataProvider()
    @State var newProgramName: String = ""
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack{
                TextField("", text: $newProgramName, prompt: Text("Program Name").foregroundColor(textFieldTextColour))
                    .withTextFieldFormatting()
                Button(action: {
                    saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Program")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }
    
    // MARK: Save Button Pressed
    func saveButtonPressed() {
        guard !newProgramName.isEmpty else { return }
        cd.addProgram(newProgramName)
        newProgramName = ""
    }
}
