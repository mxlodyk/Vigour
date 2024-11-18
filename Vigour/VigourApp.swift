//  VigourApp.swift
//  Vigour
//  Created by Melody Flavel on 4/7/2024.

import SwiftUI

@main
struct VigourApp: App {
    
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(coordinator.calendarDataProvider)
                    .environmentObject(coordinator.exerciseDataProvider)
                    .environmentObject(coordinator.healthManager)
            }
        }
    }
}
