//  CalendarView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

// MARK: Calendar View
struct CalendarView: View {
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @EnvironmentObject var hm: HealthManager
    @Namespace var animation
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(edp.currentWeek, id: \.self) { day in
                    VStack(spacing: 10) {
                        Text(edp.extractDate(date: day, format: "dd"))
                        Text(edp.extractDate(date: day, format: "EEE"))
                        // MARK: Selection Indicator
                        Circle()
                            .fill(textColour)
                            .frame(width: 8, height: 8)
                            .opacity(edp.isToday(date: day) ? 1 : 0)
                    }
                    .foregroundStyle(edp.isToday(date: day) ? .primary : .secondary)
                    .foregroundColor(edp.isToday(date: day) ? textColour : themeColour)
                    // MARK: Capsule Shape
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack {
                            // MARK: Matched Geometry Effect
                            if edp.isToday(date: day) {
                                Capsule()
                                    .fill(themeColour)
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                            }
                        }
                    )
                    .contentShape(Capsule())
                        .onTapGesture {
                            // Update current day
                            withAnimation {
                                edp.selectedDay = day
                                hm.selectedDay = day
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}
