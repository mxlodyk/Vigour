//  ExerciseView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: ExerciseView
struct ExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var edp: ExerciseDataProvider
    //@ObservedObject var cd = ExerciseDataProvider()
    
    @Binding var exercise: ExerciseEntity
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("\(exercise.name ?? "" )")
                    .withTextFormatting()
                    .foregroundColor(themeColour)
                Spacer()
                ScrollView {
                    if let sets = exercise.sets as? NSOrderedSet,
                       let setsArray = sets.array as? [SetEntity] {
                        ForEach(setsArray) { set in
                            SetView(exercise: exercise, set: set).environmentObject(edp)
                                .contextMenu {
                                    Button(action: {
                                        edp.deleteSet(set, exercise)
                                    }) {
                                        Text("Delete")
                                    }
                                }
                        }
                    }
                }
                NavigationLink(destination: AddSetView(exercise: exercise)) {
                    Text("+ Add Set")
                        .withButtonFormatting()
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("BackButton")
                        .iconStyle()
                })
        }
    }
}
