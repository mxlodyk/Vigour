//  JournalWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 21/7/2024.

import SwiftUI

struct JournalWidgetView: View {
    
    @State var showingChangeGoalBottomSheet = false
    @EnvironmentObject var edp: ExerciseDataProvider
    @State var journalGoal: Int16 = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Journal")
                    .withWidgetHeaderFormatting()
                Button(action: {
                    showingChangeGoalBottomSheet.toggle()
                }) {
                    Image("TempEditIcon")
                    //.iconStyle()
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .sheet(isPresented: $showingChangeGoalBottomSheet, content: {
                    ChangeJournalGoalView(journalGoal: $journalGoal)
                        .presentationDetents([.fraction(0.2)])
                })
                Spacer()
                Image(systemName: "checkmark.circle") // MARK: TO DO: Fill circle if meditation goal is reached.
            }
        Text("Goal: \(journalGoal) minutes")
            .font(.system(size: 14))
            .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
        NavigationLink(destination: LogJournalView()) {
            Text("Log")
                .withLogButtonFormatting()
        }
        }
        .withWidgetViewFormatting()
        .onAppear {
            journalGoal = edp.getJournalGoal()
        }
    }
}
