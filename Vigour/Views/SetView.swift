//  SetView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct SetView: View {
    
    @EnvironmentObject var edp: ExerciseDataProvider
    
    @StateObject var exercise: ExerciseEntity
    @State var set: SetEntity
    
    var body: some View {
        HStack {
            VStack {
                Text("Weight")
                    .withSetHeaderFormatting()
                Text(set.weight ?? "N/A")
                    .withSetValueFormatting()
            }
                .padding(.leading)
            VStack {
                Text("Repetitions")
                    .withSetHeaderFormatting()
                Text(set.repetitions ?? "N/A")
                    .withSetValueFormatting()
            }
            VStack {
                Text("Tempo")
                    .withSetHeaderFormatting()
                Text(set.tempo ?? "N/A")
                    .withSetValueFormatting()
            }
            VStack {
                Text("Rest")
                    .withSetHeaderFormatting()
                Text("\(set.restTime ?? "N/A") \(set.restUnit ?? "N/A")")
                    .withSetValueFormatting()
            }
            VStack {
                Image(systemName: "pencil")
                    .padding(.top)
                Spacer()
                Button(action: {
                     copyButtonPressed(set)
                }) {
                    // MARK: Copy Button
                    Image(systemName: "doc.on.doc.fill")
                        .padding(.bottom)
                }
            }
            .padding(.trailing)
        }
        .withSetFormatting()
    }
    
    // MARK: Copy Button Pressed
    func copyButtonPressed(_ set: SetEntity) {
        let copiedWeight = set.weight
        let copiedRepetitions = set.repetitions
        let copiedTempo = set.tempo
        let copiedRestTime = set.restTime
        let copiedRestUnit = set.restUnit
        edp.addSet(exercise, copiedWeight ?? "", copiedRepetitions ?? "", copiedTempo ?? "", copiedRestTime ?? "", copiedRestUnit ?? "")
    }
}
