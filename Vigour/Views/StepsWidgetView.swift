//  StepsWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 16/7/2024.

import SwiftUI

struct StepsWidgetView: View {
    
    @EnvironmentObject var hm: HealthManager
    
    @State var showingStepGoalBottomSheet = false
    @State var showingLogBottomSheet = false
    @State var stepGoal: Int32 = CoreDataProvider().getStepGoal()
    
    // MARK: Check if step goal has been reached
    var goalReached: Bool {
        if Int(hm.dailySteps) >= stepGoal {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Steps")
                    .withWidgetHeaderFormatting()
                Button(action: {
                    showingStepGoalBottomSheet.toggle()
                }) {
                    Image("TempEditIcon")
                        //.iconStyle()
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                //.padding(.bottom)
                .sheet(isPresented: $showingStepGoalBottomSheet, content: {
                    ChangeStepGoalView(stepGoal: $stepGoal)
                        .presentationDetents([.fraction(0.2)])
                })
                Spacer()
                Image(systemName: goalReached ? "checkmark.circle.fill" : "checkmark.circle")
            }
            Text("Goal: \(stepGoal)")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
                HStack {
                    Text("\(Int(hm.dailySteps)) ")
                        .withWidgetTextFormatting()
                    Spacer()
                    Image(systemName: "applewatch")
                }
            }
            Spacer()
            Button(action: {
                showingLogBottomSheet.toggle()
            }) {
                Text("Log")
                    .withLogButtonFormatting()
            }
            .sheet(isPresented: $showingLogBottomSheet, content: {
                LogStepsView()
            })
        }
        .withWidgetViewFormatting()
    }
}

/*#Preview {
    StepsWidgetView()
}*/
