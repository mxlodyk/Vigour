//  ViewModifiers.swift
//  Vigour
//  Created by Melody Flavel on 4/7/2024.

import Foundation
import SwiftUI

let themeColour = Color("Theme")
let textColour = Color("Text")
let textFieldColour = Color("TextField")
let textFieldTextColour = Color("TextFieldText")

// Title Modifier
struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Regular", size: 60))
            .foregroundColor(themeColour)
    }
}

extension View {
    
    func withTitleFormatting() -> some View {
        modifier(TitleModifier())
    }
}

// Text Modifier
struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Light", size: 30))
            .foregroundColor(themeColour)
    }
}

extension View {
    
    func withTextFormatting() -> some View {
        modifier(TextModifier())
    }
}

// Text Field Modifier
struct TextFieldModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Regular", size: 18))
            .foregroundColor(textFieldTextColour)
            .padding(.horizontal)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(textFieldColour)
            .cornerRadius(10)
    }
}

extension View {
    func withTextFieldFormatting() -> some View {
        modifier(TextFieldModifier())
    }
}

// Button Modifier
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Regular", size: 20))
            .foregroundColor(textColour)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color(themeColour))
            .cornerRadius(30)
            .shadow(radius: 10)
    }
}

extension View {
    
    func withButtonFormatting() -> some View {
        modifier(ButtonModifier())
    }
}

// Edge Padding Modifier
struct EdgePaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.top, 20)
            .padding(.bottom, 50)
    }
}

extension View {
    
    func withEdgePadding() -> some View {
        modifier(EdgePaddingModifier())
    }
}

// Icon Modifier
extension Image {
    func iconStyle() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
}
