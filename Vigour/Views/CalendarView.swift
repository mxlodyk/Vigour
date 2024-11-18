//  CalendarView.swift
//  Vigour
//  Created by Melody Flavel on 15/7/2024.

import SwiftUI

// MARK: Calendar View
struct CalendarView: View {
    
    @EnvironmentObject var cdp: CalendarDataProvider
    @EnvironmentObject var edp: ExerciseDataProvider
    @EnvironmentObject var hm: HealthManager
    @Namespace var animation
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(cdp.currentWeek, id: \.self) { day in
                    VStack(spacing: 10) {
                        Text(cdp.extractDate(date: day, format: "dd"))
                        Text(cdp.extractDate(date: day, format: "EEE"))
                        // MARK: Selection Indicator
                        Circle()
                            .fill(textColour)
                            .frame(width: 8, height: 8)
                            .opacity(cdp.isToday(date: day) ? 1 : 0)
                    }
                    .foregroundStyle(cdp.isToday(date: day) ? .primary : .secondary)
                    .foregroundColor(cdp.isToday(date: day) ? textColour : themeColour)
                    // MARK: Capsule Shape
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack {
                            // MARK: Matched Geometry Effect
                            if cdp.isToday(date: day) {
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
                                cdp.selectedDay = day
                                //edp.selectedDay = day
                                hm.selectedDay = day
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}
