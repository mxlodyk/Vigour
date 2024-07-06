//  RestDropDownList.swift
//  Vigour
//  Created by Melody Flavel on 7/7/2024.

import SwiftUI

struct DropDownList: View {
    
    let options: [String]
    @State private var selected = 0
    
    @State private var isClicked = false
    
    var body: some View {
        VStack {
            HStack {
                    Text(options[selected])
                    Spacer()
                    Image("ChangeIcon")
                        .rotationEffect(.degrees(isClicked ? -360 : 0))
                        .onTapGesture {
                            withAnimation(.snappy) { isClicked.toggle()
                                if (selected == 0) {
                                    selected = 1
                                }
                                else {
                                    selected = 0
                                }}
                        }
                }
            .withDetailFieldFormatting()
        }
    }
}

#Preview {
    DropDownList(options: ["Minutes", "Seconds"])
}
