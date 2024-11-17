//  VigourApp.swift
//  Vigour
//  Created by Melody Flavel on 4/7/2024.

import SwiftUI

@main
struct VigourApp: App {
    
    @StateObject private var edp = ExerciseDataProvider()
    @StateObject private var hm = HealthManager()

    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(edp)
                    .environmentObject(hm)
            }
        }
    }
}
