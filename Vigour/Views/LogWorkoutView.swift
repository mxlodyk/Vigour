//  LogWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

// MARK: Log Workout View
struct LogWorkoutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var cd: CoreDataProvider
    @EnvironmentObject var hm: HealthManager
    @State private var selection: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Log each set you complete to log your workout!")
                        .withTextFormatting()
                    Text("To accelerate your training regimen and make the most of your time in the gym, log each exercise as soon as it has been completed to start the rest timer.")
                        .font(.custom("MontserratRoman-Regular", size: 16))
                        .foregroundColor(themeColour)
                    Spacer()
                    // MARK: Dropdown Menu
                    DropDownMenuView(title: "Workout", prompt: "Select",
                                     options: cd.workouts.map { $0.name ?? ""}, // Map workout names to Strings for DropDownMenuView
                                     selection: $selection)
                    if let workoutName = selection,
                       let workout = cd.workouts.first(where: { $0.name == workoutName }) {
                        NavigationLink(destination: StartWorkoutView().environmentObject(workout).environmentObject(cd).environmentObject(hm)) {
                            Text("Start Workout")
                                .withButtonFormatting()
                        }
                    }
                } // End of text and dropdown menu VStack.
                .padding()
            } // End of background ZStack.
        } // End of navigation view.
        .navigationBarBackButtonHidden()
    } // End of body view.
} // End of LogWorkoutView.
