//  SettingsView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// Settings View
struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isDarkModeOn = false
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    Toggle("Metric", isOn: $isDarkModeOn)
                        .tint(themeColour)
                        .withTextFormatting()
                    Toggle("Dark Mode", isOn: $isDarkModeOn)
                        .tint(themeColour)
                        .withTextFormatting()
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
