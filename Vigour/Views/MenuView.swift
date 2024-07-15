//  MenuView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

// MARK: Menu View
struct MenuView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                CalendarView()
                // DayView()
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
                        Image("HomeButton")
                            .iconStyle()},
                trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image("SettingsButton")
                            .iconStyle()
                    })
        }
    }
    
}
