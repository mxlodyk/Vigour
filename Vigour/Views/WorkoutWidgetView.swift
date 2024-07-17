//  WorkoutWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

// MARK: Workout Widget View
struct WorkoutWidgetView: View {
    
    @EnvironmentObject var cd: CoreDataProvider
    @EnvironmentObject var hm: HealthManager
    
    @State var showingBottomSheet = false
    
    var isLogged: Bool {
        return !cd.loggedWorkouts.isEmpty || !hm.dailyWorkouts.isEmpty
    }
    
    var body: some View {
        VStack {
            if !cd.loggedWorkouts.isEmpty {
                VStack {
                    HStack {
                        Text("Workouts")
                            .withWidgetHeaderFormatting()
                        Spacer()
                        Image(systemName: isLogged ? "checkmark.circle.fill" : "checkmark.circle")
                    }
                    .padding(.bottom)
                    ScrollView {
                        // New function is here
                        if hm.dailyWorkouts.isEmpty {
                            Text("No workouts logged on Apple Watch.")
                        } else {
                            ForEach(hm.dailyWorkouts, id: \.self) { workout in
                                Text(workout.workoutName)
                            }
                        }
                        ForEach(cd.loggedWorkouts, id: \.self) { log in
                            Text(log.workout?.name ?? "Unnamed Workout")
                                .withWidgetTextFormatting()
                                // Delete Button
                                .contextMenu {
                                    Button(action: {
                                        cd.deleteLoggedWorkout(log)
                                    }) {
                                        Text("Delete")
                                    }
                                }
                        }
                    }
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            } else {
                VStack {
                    HStack {
                        Text("Workouts")
                            .foregroundColor(textColour)
                        Spacer()
                        Image(systemName: isLogged ? "checkmark.circle.fill" : "checkmark.circle")
                    }
                    VStack {
                        Text("No workout logged.")
                            .withWidgetTextFormatting()
                    }
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            }
            Button(action: {
                showingBottomSheet.toggle()
            }) {
                Text("Log")
                    .withLogButtonFormatting()
            }
            .sheet(isPresented: $showingBottomSheet, content: {
                LogWorkoutView()
            })
            .padding(.leading)
            .padding(.trailing)
        }
        .padding(.bottom)
        .background(themeColour)
        .cornerRadius(25)
        .frame(width: 200, height: 200)
    }

}

/*#Preview {
    WorkoutWidgetView().environmentObject(CoreDataProvider())
}*/
