//  LogWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

// MARK: Log Workout View
struct LogWorkoutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var cd: CoreDataProvider
    @State var selectedWorkout: WorkoutEntity?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Log each set you complete to log your workout!")
                        .withTextFormatting()
                    Text("To accelerate your training regimen and make the most of your time in the gym, log each exercise as soon as it has been completed to start the rest timer.")
                        .font(.custom("MontserratRoman-Regular", size: 16))
                        .foregroundColor(themeColour)
                    Spacer()
                    // MARK: Dropdown Menu
                    Picker("Select a workout", selection: $selectedWorkout) {
                        ForEach(cd.workouts, id: \.self) { workout in
                            Text(workout.name ?? "Unknown Workout").tag(workout as WorkoutEntity?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    if let workout = selectedWorkout {
                        NavigationLink(destination: StartWorkoutView(selectedWorkout: workout).environmentObject(cd)) {
                        Text("Select Workout")
                            .withButtonFormatting()
                        }
                    } else {
                        Button(action: {
                            print("No workout selected")
                        }) {
                            Text("Start Workout")
                                .withButtonFormatting()
                        }
                    }
                } // End of text and dropdown menu VStack.
            } // End of background ZStack.
        } // End of navigation view.
        .navigationBarBackButtonHidden()
    } // End of body view.
} // End of LogWorkoutView.
