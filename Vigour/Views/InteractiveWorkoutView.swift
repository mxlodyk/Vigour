//  InteractiveWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct InteractiveWorkoutView: View {
    
    @EnvironmentObject var selectedWorkout: WorkoutEntity
    @EnvironmentObject var cd: CoreDataProvider
    @State private var currentExerciseIndex = 0
    @State private var currentSetIndex = 0
    @State private var navigateToExercise = false
    @State private var navigateToWorkoutCompletionView = false
    @State private var navigateToExerciseTimerView = false
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                if let exercisesSet = selectedWorkout.exercises,
                   let exercisesArray = exercisesSet.array as? [ExerciseEntity] {
                    let currentExercise = exercisesArray[currentExerciseIndex]
                    VStack {
                        Text(currentExercise.name ?? "")
                        if let setsSet = currentExercise.sets,
                           let setsArray = setsSet.array as? [SetEntity] {
                            let currentSet = setsArray[currentSetIndex]
                            HStack {
                                Text(currentSet.weight ?? "")
                                Text(currentSet.repetitions ?? "")
                                Text(currentSet.tempo ?? "")
                                Text(currentSet.restTime ?? "")
                                Text(currentSet.restUnit ?? "")
                                Button(action: {
                                    if currentSetIndex < setsArray.count - 1 {
                                        currentSetIndex += 1
                                        navigateToExerciseTimerView = true
                                    } else if currentExerciseIndex < exercisesArray.count - 1 {
                                        currentSetIndex = 0
                                        currentExerciseIndex += 1
                                        navigateToExerciseTimerView = true
                                    } else {
                                        navigateToWorkoutCompletionView = true
                                    }
                                }) {
                                    Text("Done")
                                        .withButtonFormatting()
                                }
                                NavigationLink(destination: WorkoutCompletionView(), isActive: $navigateToWorkoutCompletionView) {
                                    EmptyView()
                                }
                                NavigationLink(destination: ExerciseTimerView(restTime: currentSet.restTime ?? "", restUnit: currentSet.restUnit ?? ""), isActive: $navigateToExerciseTimerView) {
                                    EmptyView()
                                }
                            }
                        }
                    }
                } else {
                    Text("No exercises found.")
                }
            }
        } // End of background ZStack.
        .navigationBarBackButtonHidden()
    } // End of body view.
} // End of InteractiveWorkoutView view.
