//  MenuView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                NavigationLink(destination: ProgramsView()) {
                    Text("Programs")
                        .withButtonFormatting()
                }
                Spacer()
            }
            .withEdgePadding()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MenuView()
}
