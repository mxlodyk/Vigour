//  AppCoordinator.swift
//  Vigour
//  Created by Melody Flavel on 18/11/2024.

import Foundation

class AppCoordinator: ObservableObject {
    @Published var calendarDataProvider: CalendarDataProvider
    @Published var exerciseDataProvider: ExerciseDataProvider
    @Published var healthManager: HealthManager
    
    init() {
        let cdp = CalendarDataProvider()
        self.calendarDataProvider = cdp
        self.exerciseDataProvider = ExerciseDataProvider(calendarDataProvider: cdp)
        self.healthManager = HealthManager()
    }
}
