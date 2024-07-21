//  InteractiveWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct InteractiveWorkoutView: View {
    
    @EnvironmentObject var selectedWorkout: WorkoutEntity
    @EnvironmentObject var cd: CoreDataProvider
    @EnvironmentObject var hm: HealthManager
    @State private var currentExerciseIndex = 0
    @State private var currentSetIndex = 0
    @State private var navigateToWorkoutCompletionView = false
    @State private var navigateToExerciseTimerView = false
    @State private var nextSet: SetEntity? = nil
    
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
                                    nextSet = currentSet
                                    navigateToExerciseTimerView = true
                                }) {
                                    Text("Done")
                                        .withButtonFormatting()
                                }
                                NavigationLink(destination: ExerciseTimerView(restTime: nextSet?.restTime ?? "", restUnit: nextSet?.restUnit ?? ""), isActive: $navigateToExerciseTimerView) {
                                    EmptyView()
                                }
                                NavigationLink(destination: WorkoutCompletionView().environmentObject(selectedWorkout), isActive: $navigateToWorkoutCompletionView) {
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
        .onChange(of: navigateToExerciseTimerView) { value in
            if value {
                if let exercisesSet = selectedWorkout.exercises,
                   let exercisesArray = exercisesSet.array as? [ExerciseEntity] {
                    let currentExercise = exercisesArray[currentExerciseIndex]
                    if let setsSet = currentExercise.sets,
                       let setsArray = setsSet.array as? [SetEntity] {
                        if currentSetIndex < setsArray.count - 1 {
                            currentSetIndex += 1
                        } else if currentExerciseIndex < exercisesArray.count - 1 {
                            currentSetIndex = 0
                            currentExerciseIndex += 1
                        } else {
                            navigateToWorkoutCompletionView = true
                            navigateToExerciseTimerView = false
                            cd.logWorkout(selectedWorkout)
                        }
                    }
                }
            }
        }
    } // End of body view.
} // End of InteractiveWorkoutView view.
