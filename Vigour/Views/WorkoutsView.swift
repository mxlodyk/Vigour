//  WorkoutsView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Workouts View
struct WorkoutsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingBottomSheet = false
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @Binding var program: ProgramEntity
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    if let workouts = program.workouts?.array as? [WorkoutEntity] {
                        ForEach(workouts) { workout in
                            WorkoutRowView(program: $program, workout: workout)
                                .contextMenu {
                                    Button(action: {
                                        edp.deleteWorkout(workout, program)
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
                AddWorkoutView(program: $program).environmentObject(edp)
                    .presentationDetents([.fraction(0.2)])
            })
        }
    }
}
