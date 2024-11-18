//  CalendarDataProvider.swift
//  Vigour
//  Created by Melody Flavel on 18/11/2024.

import Foundation

class CalendarDataProvider: ObservableObject {
    
    let shared = CoreDataManager.instance
    
    @Published var currentWeek: [Date] = []
    @Published var selectedDay: Date = Date()
    
    init() {
        fetchCurrentWeek()
    }
    
    // MARK: Fetch Current Week
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        guard let week = calendar.dateInterval(of: .weekOfMonth, for: today),
            let firstWeekDay = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: today) + 1, to: today) else {
                return
        }
        currentWeek = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: firstWeekDay) }
    }
    
    // MARK: Extract Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // MARK: Check Current Date
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, inSameDayAs: selectedDay)
    }
    
    // MARK: Save
    func save() {
        shared.save()
        fetchCurrentWeek()
    }
}
