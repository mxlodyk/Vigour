//  InteractiveSetView.swift
//  Vigour
//  Created by Melody Flavel on 21/7/2024.

import SwiftUI

struct InteractiveSetView: View {
    
    @EnvironmentObject var cd: ExerciseDataProvider
    
    @StateObject var exercise: ExerciseEntity
    @State var set: SetEntity
    
    var body: some View {
        HStack {
            VStack {
                Text("Weight")
                    .withSetHeaderFormatting()
                Text(set.weight ?? "N/A")
                    .withSetValueFormatting()
                Button(action: {
                    adjustButtonPressed()
                }) {
                    Image("AdjustButton")
                }
            }
            .padding(.leading)
            VStack {
                Text("Repetitions")
                    .withSetHeaderFormatting()
                Text(set.repetitions ?? "N/A")
                    .withSetValueFormatting()
                Button(action: {
                    adjustButtonPressed()
                }) {
                    Image("AdjustButton")
                }
            }
            VStack {
                Text("Tempo")
                    .withSetHeaderFormatting()
                Text(set.tempo ?? "N/A")
                    .withSetValueFormatting()
                Button(action: {
                    adjustButtonPressed()
                }) {
                    Image("AdjustButton")
                }
            }
            .padding(.trailing)
        }
        .withInteractiveSetFormatting()
    }
    
    // MARK: Adjust Button Pressed
    func adjustButtonPressed() {
        
    }
}

