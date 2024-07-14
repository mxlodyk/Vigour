//  ActivityCard.swift
//  Vigour
//  Created by Melody Flavel on 12/7/2024.

import SwiftUI

struct ActivityCard: View {
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                    Text("Daily steps")
                    Text("Goal: 10,000")
                        .font(.caption)
                }
                Spacer()
                Image(systemName: "figure.walk")
                    .foregroundColor(.blue)
            }
            .padding()
            
            Text("6,432")
                .font(.system(size: 26))
        }
        .padding()
    }
}

#Preview {
    ActivityCard()
}
