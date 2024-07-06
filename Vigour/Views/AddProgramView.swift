//  AddProgramView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct AddProgramView: View {
    
    @State var newProgramName: String = ""
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack{
                TextField("Program Name", text: $newProgramName)
                    .withTextFieldFormatting()
                Text("Create Program")
                    .withButtonFormatting()
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }
}

#Preview {
    AddProgramView()
}
