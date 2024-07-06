//  ExercisesView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct ExercisesView: View {
    
    @Binding var program: ProgramModel
    @Binding var workout: WorkoutModel
    @Environment(\.presentationMode) var presentationMode
    @State var showingBottomSheet = false
    let programs: [ProgramModel] = DataProvider.getPrograms()
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(DataProvider.getPrograms()) { program in
                        if program.id == self.program.id {
                            ForEach(program.workouts) { workout in
                                if workout.id == self.workout.id {
                                    ForEach(workout.exercises) { exercise in
                                        ExerciseRowView(exercise: exercise)
                                    }
                                }
                            }
                        }
                    }
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
                    AddExerciseView(program: $program, workout: workout)
                        .presentationDetents([.fraction(0.35)])
                })
            }
            .withEdgePadding()
        }
    }
}
