//  WorkoutsView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct WorkoutsView: View {
    
    @Binding var program: ProgramModel
    var programID: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(program.workouts) { workout in
                        WorkoutRowView(workout: workout)
                    }
                }
                .withEdgePadding()
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("BackButton")
                            .iconStyle()
                    },
                trailing:
                    NavigationLink(destination: AddWorkoutView()) {
                        Image("AddButton")
                            .iconStyle()
                    })
        }
    }
}
