//  WorkoutCompletionView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct WorkoutCompletionView: View {
    
    @EnvironmentObject var selectedWorkout: WorkoutEntity
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(selectedWorkout.name ?? "")
                Text("COMPLETED!")
                Text("Some animation.")
            }
        }
        .navigationBarBackButtonHidden()
    }
}
