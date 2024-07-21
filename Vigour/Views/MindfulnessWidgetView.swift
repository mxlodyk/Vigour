//  MindfulnessWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 21/7/2024.

import SwiftUI

struct MindfulnessWidgetView: View {
    var body: some View {
        VStack {
            Text("Mindfulness")
                .withWidgetHeaderFormatting()
        }
        .frame(width: 200, height: 200)
        .background(themeColour)
        .cornerRadius(25)
    }
}
