//  CaloriesWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 17/7/2024.

import SwiftUI

struct CaloriesWidgetView: View {
    var body: some View {
        VStack {
            Text("Calories")
                .withWidgetHeaderFormatting()
            NavigationLink(destination: FoodSearchView()) {
                Text("Log")
                    .withLogButtonFormatting()
            }
        }
    
        .frame(width: 200, height: 200)
        .background(themeColour)
        .cornerRadius(25)
    }
}
