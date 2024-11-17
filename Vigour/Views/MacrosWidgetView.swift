//  MacrosWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 17/7/2024.

import SwiftUI

struct MacrosWidgetView: View {
    
    @State var showingMacroGoalBottomSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Macronutrients")
                    .withWidgetHeaderFormatting()
                Button(action: {
                    showingMacroGoalBottomSheet.toggle()
                }) {
                    Image("TempEditIcon")
                        //.iconStyle()
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .sheet(isPresented: $showingMacroGoalBottomSheet, content: {
                    ChangeMacroGoalView()
                        .presentationDetents([.fraction(0.5)])
                })
                Spacer()
                Image(systemName: "checkmark.circle") // MARK: TO DO: Fill circle if calorie goal is reached.
            }
            Spacer()
            NavigationLink(destination: FoodSearchView()) {
                Text("Log")
                    .withLogButtonFormatting()
            }
        }
        .withWidgetViewFormatting()
    }
}

