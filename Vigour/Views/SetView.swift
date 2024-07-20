//  SetView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct SetView: View {
    
    @State var set: SetEntity
    
    var body: some View {
        HStack {
            Text("Weight\n\(set.weight ?? "N/A")")
                .withSetTextFormatting()
            Text("Repetitions\n\(set.repetitions ?? "N/A")")
                .withSetTextFormatting()
            Text("Tempo\n\(set.tempo ?? "N/A")")
                .withSetTextFormatting()
            HStack {
                Text("Rest\n\(set.restTime ?? "N/A") \(set.restUnit ?? "N/A")")
                    .withSetTextFormatting()
            }
        }
        .withSetRowFormatting()
    }
}
