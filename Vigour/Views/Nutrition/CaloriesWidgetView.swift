//  CaloriesWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 17/7/2024.

import SwiftUI

struct CaloriesWidgetView: View {
    
    @State var showingCalorieGoalBottomSheet = false
    @State var showingLogBottomSheet = false
    @State var calorieGoal: Int16 = CoreDataProvider().getCalorieGoal()
    
    var body: some View {
        VStack {
            HStack {
                Text("Calories")
                    .withWidgetHeaderFormatting()
                Button(action: {
                    showingCalorieGoalBottomSheet.toggle()
                }) {
                    Image("TempEditIcon")
                        //.iconStyle()
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .sheet(isPresented: $showingCalorieGoalBottomSheet, content: {
                    ChangeCalorieGoalView(calorieGoal: $calorieGoal)
                        .presentationDetents([.fraction(0.2)])
                })
                Spacer()
                Image(systemName: "checkmark.circle") // MARK: TO DO: Fill circle if calorie goal is reached.
            }
            Text("Goal: \(calorieGoal)")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        
            Button(action: {
                showingLogBottomSheet.toggle()
            }) {
                Text("Log")
                    .withLogButtonFormatting()
            }
            .sheet(isPresented: $showingLogBottomSheet, content: {
                LogCaloriesView()
                    .presentationDetents([.fraction(0.2 )])
            })
        }
        .withWidgetViewFormatting()
    }
}
