//  MeditationWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 21/7/2024.

import SwiftUI

struct MeditationWidgetView: View {
    
    @State var showingMeditationGoalBottomSheet = false
    @State var meditationGoal: Int16 = CoreDataProvider().getMeditationGoal()
    
    var body: some View {
        VStack {
            HStack {
                Text("Meditation")
                    .withWidgetHeaderFormatting()
                Button(action: {
                    showingMeditationGoalBottomSheet.toggle()
                }) {
                    Image("TempEditIcon")
                        //.iconStyle()
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .sheet(isPresented: $showingMeditationGoalBottomSheet, content: {
                    ChangeMeditationGoalView(meditationGoal: $meditationGoal)
                        .presentationDetents([.fraction(0.2)])
                })
                Spacer()
                Image(systemName: "checkmark.circle") // MARK: TO DO: Fill circle if meditation goal is reached.
            }
            Text("Goal: \(meditationGoal) minutes")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            NavigationLink(destination: LogMeditationView()) {
                Text("Log")
                    .withLogButtonFormatting()
            }
        }
        .withWidgetViewFormatting()
    }
}
