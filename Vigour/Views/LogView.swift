//  LogView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

struct LogView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var cd: CoreDataProvider
    @State var selectedWorkout: WorkoutEntity?
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack{
                Picker("Select a workout", selection: $selectedWorkout) {
                    ForEach(cd.workouts, id: \.self) { workout in
                               Text(workout.name ?? "Unknown Workout").tag(workout as WorkoutEntity?)
                           }
                       }
                       .pickerStyle(MenuPickerStyle())
                Button(action: {
                    guard let workout = selectedWorkout else {
                                            // Handle case where no workout is selected, e.g., show an alert
                                            print("No workout selected")
                                            return
                                        }
                    cd.logWorkout(selectedWorkout!)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Log Workout")
                        .withButtonFormatting()
                }
            }
            .withEdgePadding()
            .padding(.top, 30)
        }
    }

}

/*#Preview {
    LogView()
}*/
