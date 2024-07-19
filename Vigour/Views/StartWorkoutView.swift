//  StartWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 19/7/2024.

import SwiftUI

// MARK: Start Workout View
struct StartWorkoutView: View {
    
    @State var selectedWorkout: WorkoutEntity
    @EnvironmentObject var cd: CoreDataProvider
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(selectedWorkout.name ?? "")
                    .withTitleFormatting()
                Spacer()
                // Convert NS Ordered Set to Array
                if let exercisesSet = selectedWorkout.exercises,
                   let exercisesArray = exercisesSet.array as? [ExerciseEntity] {
                        ForEach(exercisesArray) { exercise in
                            Text(exercise.name ?? "")
                        }
                    } // End of exercise loop.
                Spacer()
                NavigationLink(destination: InteractiveWorkoutView()) {
                    Text("Start Workout")
                        .withButtonFormatting()
                }
            }
        } // End of background ZStack.
        .navigationBarBackButtonHidden()
    } // End of body view.
} // End of StartWorkoutView.
