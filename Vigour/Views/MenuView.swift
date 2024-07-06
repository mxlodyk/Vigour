//  MenuView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

struct MenuView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("Home")
                            .iconStyle()},
                trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image("Settings")
                            .iconStyle()
                    })
        }
    }
}

#Preview {
    MenuView()
}
