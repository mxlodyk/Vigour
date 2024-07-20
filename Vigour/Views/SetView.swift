//  SetView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct SetView: View {
    
    @EnvironmentObject var cd: CoreDataProvider
    
    @StateObject var exercise: ExerciseEntity
    @State var set: SetEntity
    
    var body: some View {
        HStack {
            Text("Weight\n\(set.weight ?? "N/A")")
                .withSetTextFormatting()
                .padding(.leading)
            Text("Repetitions\n\(set.repetitions ?? "N/A")")
                .withSetTextFormatting()
            Text("Tempo\n\(set.tempo ?? "N/A")")
                .withSetTextFormatting()
            Text("Rest\n\(set.restTime ?? "N/A") \(set.restUnit ?? "N/A")")
                .withSetTextFormatting()
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
        .withSetRowFormatting()
    }
    
    // MARK: Copy Button Pressed
    func copyButtonPressed(_ set: SetEntity) {
        let copiedWeight = set.weight
        let copiedRepetitions = set.repetitions
        let copiedTempo = set.tempo
        let copiedRestTime = set.restTime
        let copiedRestUnit = set.restUnit
        cd.addSet(exercise, copiedWeight ?? "", copiedRepetitions ?? "", copiedTempo ?? "", copiedRestTime ?? "", copiedRestUnit ?? "")
    }
}
