//  StartWorkoutView.swift
//  Vigour
//  Created by Melody Flavel on 19/7/2024.

import SwiftUI

// MARK: Start Workout View
struct StartWorkoutView: View {
    
    @EnvironmentObject var selectedWorkout: WorkoutEntity
    @EnvironmentObject var cd: CoreDataProvider
    @EnvironmentObject var hm: HealthManager
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text(selectedWorkout.name ?? "")
                        .withTitleFormatting()
                    Image(systemName: "shuffle")
                }
                Spacer()
                // Convert NS Ordered Set to Array
                ScrollView {
                    if let exercisesSet = selectedWorkout.exercises,
                       let exercisesArray = exercisesSet.array as? [ExerciseEntity] {
                        ForEach(exercisesArray) { exercise in
                            Text(exercise.name ?? "")
                                .withTextFormatting()
                            if let setsSet = exercise.sets,
                               let setsArray = setsSet.array as? [SetEntity] {
                                ForEach(setsArray) { set in
                                    SetView(exercise: exercise, set: set)
                                }
                            }
                        }
                    } // End of exercise loop.
                }
                Spacer()
                NavigationLink(destination: StartTimerView().environmentObject(selectedWorkout)) {
                    Text("Start Workout")
                        .withButtonFormatting()
                }
            }
        } // End of background ZStack.
        .navigationBarBackButtonHidden()
    } // End of body view.
} // End of StartWorkoutView.
