//  StepsWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 16/7/2024.

import SwiftUI

struct StepsWidgetView: View {
    
    @EnvironmentObject var hm: HealthManager
    
    @State var showingStepGoalBottomSheet = false
    @State var showingLogBottomSheet = false
    @State var stepGoal: Int = 2000
    
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
                Spacer()
                Image(systemName: goalReached ? "checkmark.circle.fill" : "checkmark.circle")
            }
            HStack {
                Text("Goal: \(stepGoal)")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    showingStepGoalBottomSheet.toggle()
                }) {
                    Text("Change")
                        .font(.system(size: 14))
                }
                .padding(.bottom)
                .sheet(isPresented: $showingStepGoalBottomSheet, content: {
                    ChangeStepGoalView(stepGoal: $stepGoal)
                        .presentationDetents([.fraction(0.2)])
                })
            }
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
