//  SettingsView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Settings View
struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isDarkModeOn = false
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Settings")
                    .withTextFormatting()
                NavigationLink(destination: ProgramsView()) {
                    Text("Programs")
                        .withButtonFormatting()
                }
                Spacer()
            }
            .withEdgePadding()
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("BackButton")
                        .iconStyle()
                })
        }
    }
}
