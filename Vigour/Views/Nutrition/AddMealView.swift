//  AddMealView.swift
//  Vigour
//  Created by Melody Flavel on 17/11/2024.

import SwiftUI

struct AddMealView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("BackButton")
                    })
                    .padding(.trailing, 25)
                    Text("Add Meal")
                        .withHeading2Formatting()
                }
                Spacer()
            }
        }
    }
}
