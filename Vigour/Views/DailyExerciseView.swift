//  DailyExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

// MARK: Daily Exercise View
struct DailyExerciseView: View {
    
    @EnvironmentObject var cd: CoreDataProvider
    @EnvironmentObject var hm: HealthManager
    
    var body: some View {
        VStack {
            Text("Exercise")
                .withTextFormatting()
                // Align text to the left
                .frame(maxWidth: .infinity, alignment: .leading)
            // MARK: Daily Exercise Widgets
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 20) {
                    WorkoutWidgetView()
                        .environmentObject(cd)
                    StepsWidgetView()
                        .environmentObject(hm)
                }
            }
        }
        // Update view when view appears
        .onAppear {
            cd.getLoggedWorkoutsForSelectedDay()
            hm.fetchSelectedDaySteps()
            hm.fetchSelectedDayWorkouts()
        }
        // Update view if selected day changes
        .onChange(of: cd.selectedDay) {
            cd.getLoggedWorkoutsForSelectedDay()
            hm.fetchSelectedDaySteps()
            hm.fetchSelectedDayWorkouts()
        }
    }
    
}

/*#Preview {
    DailyExerciseView().environmentObject(CoreDataProvider())
}*/