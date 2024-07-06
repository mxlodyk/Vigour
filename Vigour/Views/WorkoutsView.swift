//  WorkoutsView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct WorkoutsView: View {
    
    @Binding var program: ProgramModel
    @Environment(\.presentationMode) var presentationMode
    @State var showingBottomSheet = false
    @StateObject var workoutViewModel = WorkoutViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(workoutViewModel.programs) { program in
                        if program.id == self.program.id {
                            ForEach(program.workouts) { workout in
                                WorkoutRowView(program: $program, workout: workout)
                            }
                        }
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
                    Button(action: {
                        showingBottomSheet.toggle()
                    }) {
                        Image("AddButton")
                            .iconStyle()
                    })
            .sheet(isPresented: $showingBottomSheet, content: {
                AddWorkoutView(program: $program, workoutViewModel: workoutViewModel)
                    .presentationDetents([.fraction(0.2 )])
            })
        }
    }
}
