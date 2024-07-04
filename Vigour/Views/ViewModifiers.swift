//  ViewModifiers.swift
//  Vigour
//  Created by Melody Flavel on 4/7/2024.

import Foundation
import SwiftUI

let themeColour = Color("Theme")

struct TitleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Regular", size: 60))
            .foregroundColor(themeColour)
    }
}

extension View {
    
    func withTitleFormatting() -> some View {
        modifier(TitleViewModifier())
    }
}

struct TextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Light", size: 30))
            .foregroundColor(themeColour)
    }
}

extension View {
    
    func withTextFormatting() -> some View {
        modifier(TextViewModifier())
    }
}

struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color(themeColour))
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}

extension View {
    
    func withButtonFormatting() -> some View {
        modifier(ButtonViewModifier())
    }
}
