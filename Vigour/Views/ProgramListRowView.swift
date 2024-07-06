//  ListRowView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

struct ProgramListRowView: View {
    
    @State var program: ProgramModel
    
    var body: some View {
        HStack {
            NavigationLink(destination: WorkoutsView(program: $program)){
                Text(program.name)
                .withButtonFormatting()
            }
        }
    }
}

