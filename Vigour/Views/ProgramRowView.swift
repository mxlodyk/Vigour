//  ListRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Program Row View
struct ProgramRowView: View {
    
    @State var program: ProgramEntity
    
    var body: some View {
        NavigationLink(destination: WorkoutsView(program: $program)) {
            Text(program.name ?? "")
                .withButtonFormatting()
        }
    }
}

