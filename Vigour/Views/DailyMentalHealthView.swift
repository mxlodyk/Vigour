//  DailyMentalHealthView.swift
//  Vigour
//  Created by Melody Flavel on 21/7/2024.

import SwiftUI

struct DailyMentalHealthView: View {
    var body: some View {
        VStack {
            Text("Mental Health")
                .withTextFormatting()
                // Align text to the left
                .frame(maxWidth: .infinity, alignment: .leading)
            // MARK: Daily Exercise Widgets
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 20) {
                    MindfulnessWidgetView()
                    SleepWidgetView()
                }
            }
        }
    }
}
