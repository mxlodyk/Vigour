//  DailyNutritionView.swift
//  Vigour
//  Created by Melody Flavel on 17/7/2024.

import SwiftUI

struct DailyNutritionView: View {
    var body: some View {
        VStack {
            Text("Nutrition")
                .withTextFormatting()
                // Align text to the left
                .frame(maxWidth: .infinity, alignment: .leading)
            // MARK: Daily Exercise Widgets
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 20) {
                    CaloriesWidgetView()
                    MacrosWidgetView()
                }
            }
        }
    }
}

/*#Preview {
    DailyNutritionView()
}*/
