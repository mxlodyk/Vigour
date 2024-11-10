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
                    Spacer()
                    Text("Log your workout and maintain your streak!")
                        .multilineTextAlignment(.center) // Center alignment
                        .withTextFormatting()
                    Text("To accelerate your training regimen and make the most of your time in the gym, log each exercise as soon as it has been completed to start the rest timer.")
                        .multilineTextAlignment(.center) // Center alignment
                        .font(.custom("MontserratRoman-Regular", size: 16))
                        .foregroundColor(themeColour)
                        .padding()
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
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("BackButton")
                    .iconStyle()
            })
    } // End of body view.
} // End of LogWorkoutView.
