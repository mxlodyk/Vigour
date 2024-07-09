//  RestDropDownList.swift
//  Vigour
//  Created by Melody Flavel on 7/7/2024.

import SwiftUI

// Rest Unit View
struct RestUnitView: View {
    
    @Binding var newExerciseRestUnit: String
    
    @State var index: Int = 0
    @State private var isClicked = false
    
    let options: [String] = ["Min", "Sec"]
    
    var body: some View {
        VStack {
            HStack {
                    Text(options[index])
                    Spacer()
                    Image("ChangeIcon")
                        .rotationEffect(.degrees(isClicked ? -360 : 0))
                        .onTapGesture {
                            withAnimation(.snappy) { isClicked.toggle()
                                if (index == 0) {
                                    index = 1
                                    newExerciseRestUnit = options[index]
                                }
                                else {
                                    index = 0
                                    newExerciseRestUnit = options[index]
                                }}
                        }
                }
            .withDetailFieldFormatting()
        }
    }
}
