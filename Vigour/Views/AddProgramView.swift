//  AddProgramView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct AddProgramView: View {
    
    @State var newProgramName: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack{
                TextField("Program Name", text: $newProgramName)
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
        @State var newProgram = ProgramModel(name: newProgramName, workouts: [])
        DataProvider.addProgram(programModel: &newProgram)
    }
}
