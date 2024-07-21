//  DropDownMenuView.swift
//  Vigour
//  Created by Melody Flavel on 22/7/2024.

import SwiftUI

// MARK: Drop Down Menu View
struct DropDownMenuView: View {
    
    let title: String
    let prompt: String
    let options: [String]
    
    @State private var isExpanded = false
    @Binding var selection: String?
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                Text(title)
                    .withTextFormatting()
                VStack {
                    HStack {
                        Text(selection ?? prompt)
                            .foregroundColor(themeColour)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(themeColour)
                            .rotationEffect(.degrees(isExpanded ? -180 : 0))
                    }
                    .frame(height: 40)
                    .background(textFieldColour)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            isExpanded.toggle()
                        }
                    }
                    
                    if isExpanded {
                        VStack {
                            ForEach(options, id: \.self) { option in
                                HStack {
                                    Text(option)
                                        .foregroundColor(selection == option ? themeColour : .gray)
                                    Spacer()
                                    if selection == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(themeColour)
                                    }
                                }
                                .frame(height: 40)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        selection = option
                                        isExpanded.toggle()
                                    }
                                }
                            }
                            .transition(.move(edge: .bottom))
                        }
                    }
                }
                .background(textFieldColour)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
                .frame(width: 300)
            }
        }
    }
}

/*#Preview {
    DropDownMenuView(title: "Workout", prompt: "Select", options: ["Glutes", "Hamstrings", "Quads"], selection: .constant("Glutes"))
}*/
