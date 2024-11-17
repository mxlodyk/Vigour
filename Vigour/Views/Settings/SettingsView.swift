//  SettingsView.swift
//  Vigour
//  Created by Melody Flavel on 6/7/2024.

import SwiftUI

// MARK: Settings View
struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isDarkModeOn = false
    @State private var selectedSystem: MeasurementSystem = CoreDataProvider().getMeasurementSystem()
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Settings")
                    .withTextFormatting()
                HStack {
                    Text("System")
                    Spacer()
                    Picker("System", selection: $selectedSystem) {
                        ForEach(MeasurementSystem.allCases, id: \.self) { system in
                            Text(system.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedSystem) { newSystem in
                        CoreDataProvider().saveMeasurementSystem(newSystem)
                    }
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

enum MeasurementSystem: String, CaseIterable {
    case metric = "Metric"
    case imperial = "Imperial"
}
