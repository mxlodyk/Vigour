//  ProgramsView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

struct ProgramsView: View {
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .withButtonFormatting()
                Spacer()
            }
            .withEdgePadding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProgramsView()
}
