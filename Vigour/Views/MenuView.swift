//  MenuView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

// MARK: Menu View
struct MenuView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var cd = CoreDataProvider()
    @StateObject var hm = HealthManager()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                CalendarView()
                    .environmentObject(cd)
                    .environmentObject(hm)
                DailyExerciseView()
                    .environmentObject(cd)
                    .environmentObject(hm)
                Spacer()
                NavigationLink(destination: LogView().environmentObject(cd)) {
                    Image("LogButton")
                }
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

/*#Preview {
    MenuView().environmentObject(CoreDataProvider())
}*/
