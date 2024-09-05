//  ExercisesView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Exercises View
struct ExercisesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingBottomSheet = false
    
    @ObservedObject var cd = CoreDataProvider()
    @Binding var program: ProgramEntity
    @Binding var workout: WorkoutEntity
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    if let exercises = workout.exercises?.array as? [ExerciseEntity] {
                        ForEach(exercises) { exercise in
                            ExerciseRowView(exercise: exercise)
                                .contextMenu {
                                    Button(action: {
                                        cd.deleteExercise(exercise, workout)
                                    }) {
                                        Text("Delete")
                                    }
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
                AddExerciseView(cd: cd, program: $program, workout: $workout)
                    .presentationDetents([.fraction(0.2)])
            })
        }
    }
}
