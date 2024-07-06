//  ListRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct ProgramListRowView: View {
    
    @State var program: ProgramModel
    
    var body: some View {
        NavigationLink(destination: WorkoutsView(program: $program, programID: $program.id)) {
            Text(program.name)
                .withButtonFormatting()
        }
    }
}

