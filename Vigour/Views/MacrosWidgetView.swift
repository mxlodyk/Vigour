//  MacrosWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 17/7/2024.

import SwiftUI

struct MacrosWidgetView: View {
    var body: some View {
        VStack {
            Text("Macronutrients")
                .withWidgetHeaderFormatting()
        }
        .frame(width: 200, height: 200)
        .background(themeColour)
        .cornerRadius(25)
    }
}

/*#Preview {
    MacrosWidgetView()
}*/
