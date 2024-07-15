//  SettingsView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Settings View
struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Settings")
                    .withTextFormatting()
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
