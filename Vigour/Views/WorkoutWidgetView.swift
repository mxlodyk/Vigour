//  WorkoutWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

// MARK: Workout Widget View
struct WorkoutWidgetView: View {
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @EnvironmentObject var hm: HealthManager
    
    // MARK: Check if user has any workouts logged in either loggedWorkouts or syncedWorkouts
    var isLogged: Bool {
        return !edp.loggedWorkouts.isEmpty || !hm.syncedWorkouts.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                    HStack {
                        Text("Workouts")
                            .withWidgetHeaderFormatting()
                        NavigationLink(destination: ProgramsView()) {
                            Image("TempEditIcon")
                                //.iconStyle()
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                        Spacer()
                        Image(systemName: isLogged ? "checkmark.circle.fill" : "checkmark.circle")
                    }
                    .padding(.bottom)
                    ScrollView {
                        HStack {
                            if hm.syncedWorkouts.isEmpty {
                                Text("No workouts logged on Apple Watch.")
                                    .withWidgetTextFormatting()
                                    .contextMenu {
                                        Text("No workouts logged on Apple Watch.")
                                    }
                            } else {
                                ForEach(hm.syncedWorkouts, id: \.self) { workout in
                                    Text(workout.workoutName)
                                        .withWidgetTextFormatting()
                                        .contextMenu {
                                            Text("\(workout.workoutName)")
                                        }
                                }
                            }
                            Spacer()
                            Image(systemName: "applewatch")
                        }
                                ForEach(edp.loggedWorkouts, id: \.self) { workout in
                                    HStack {
                                        Text(workout.workout?.name ?? "Unnamed Workout")
                                            .withWidgetTextFormatting()
                                            .contextMenu {
                                                Button(action: {
                                                    edp.deleteLoggedWorkout(workout)
                                                }) {
                                                    Text("Delete")
                                                }
                                            }
                                            .ignoresSafeArea()
                                        Image(systemName: "iphone")
                                    }
                                }
                    }
                    Spacer()
                }
            NavigationLink(destination: LogWorkoutView().environmentObject(edp).environmentObject(hm)) {
                Text("Log")
                    .withLogButtonFormatting()
            }
        } // End of Line 20 VStack.
        .withWidgetViewFormatting()
        .onChange(of: edp.loggedWorkouts) {
            edp.getLoggedWorkoutsForSelectedDay()
        }
        
    } // End of View.

} // End of WorkoutWidgetView.
