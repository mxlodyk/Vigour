//  AddProgramView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct AddProgramView: View {
    
    @State var newProgramName: String = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var programViewModel: ProgramViewModel
    
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
    
    func saveButtonPressed() {
        let newProgram = ProgramModel(name: newProgramName, workouts: [])
        programViewModel.addProgram(newProgram)
    }
}
