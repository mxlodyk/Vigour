//  WorkoutCompletionView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

// MARK: Workout Completion View
struct WorkoutCompletionView: View {
    
    @EnvironmentObject var selectedWorkout: WorkoutEntity
    @EnvironmentObject var edp: ExerciseDataProvider
    @EnvironmentObject var hm: HealthManager
    @State private var navigateToMenuView = false
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(selectedWorkout.name ?? "")
                Text("COMPLETED!")
                Text("Some animation.")
                NavigationLink(destination: MenuView(), isActive: $navigateToMenuView) {
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                navigateToMenuView = true
            }
        }
    }
}
