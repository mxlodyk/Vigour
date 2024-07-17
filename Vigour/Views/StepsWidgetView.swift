//  StepsWidgetView.swift
//  Vigour
//  Created by Melody Flavel on 16/7/2024.

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let quantity: String
}

struct StepsWidgetView: View {
    
    @EnvironmentObject var hm: HealthManager 
    
    var goalReached: Bool {
        // Return true if step goal has been reached
        return false
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Steps")
                    .withWidgetHeaderFormatting()
                Spacer()
                Image(systemName: goalReached ? "checkmark.circle.fill" : "checkmark.circle")
            }
            Text("Goal: 10,000")
                .font(.system(size: 14))
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                Text("\(Int(hm.dailySteps)) ")
                    .withWidgetTextFormatting()
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.top)
        .background(themeColour)
        .cornerRadius(25)
        .frame(width: 200, height: 200)
        .onAppear {
            hm.fetchSelectedDaySteps()
        }
    }
}

/*#Preview {
    StepsWidgetView()
}*/
