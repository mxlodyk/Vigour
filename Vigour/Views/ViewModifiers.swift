//  ViewModifiers.swift
//  Vigour
//  Created by Melody Flavel on 4/7/2024.

import Foundation
import SwiftUI

let themeColour = Color("Theme")
let textColour = Color("Text")
let textFieldColour = Color("TextField")
let textFieldTextColour = Color("TextFieldText")
let widgetLogRowColour = Color("WidgetLogRowColour")

// MARK: Title Modifier
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

// MARK: Text Modifier
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

// MARK: Text Field Modifier
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

// MARK: Detail Field Modifier
struct DetailFieldModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading, 5)
            .font(.custom("MontserratRoman-Regular", size: 16))
            .foregroundColor(textFieldTextColour)
            .frame(height: 30)
            .background(textFieldColour)
            .cornerRadius(10)
    }
}

extension View {
    func withDetailFieldFormatting() -> some View {
        modifier(DetailFieldModifier())
    }
}

// MARK: Button Modifier
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
            .cornerRadius(30)
            .shadow(color: themeColour, radius: 5)
            .padding(.top, 5)
    }
}

extension View {
    
    func withButtonFormatting() -> some View {
        modifier(ButtonModifier())
    }
}

// MARK: Edge Padding Modifier
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

// MARK: Icon Modifier
extension Image {
    func iconStyle() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
}

// MARK: Widget View Modifier
struct WidgetViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading)
            .padding(.trailing)
            .padding(.top)
            .padding(.bottom)
            .background(themeColour)
            .cornerRadius(25)
            .frame(width: 350, height: 200)
    }
}

extension View {
    func withWidgetViewFormatting() -> some View {
        modifier(WidgetViewModifier())
    }
}

// MARK: Widget Text Modifier
struct WidgetTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading)
            .font(.custom("MontserratRoman-Regular", size: 14))
            .foregroundColor(textColour)
            .frame(height: 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(widgetLogRowColour))
            .cornerRadius(5)
    }
}

extension View {
    
    func withWidgetTextFormatting() -> some View {
        modifier(WidgetTextModifier())
    }
}

// MARK: Widget Header Modifier
struct WidgetHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(textColour)
    }
}

extension View {
    func withWidgetHeaderFormatting() -> some View {
        modifier(WidgetHeaderModifier())
    }
}

// MARK: Log Button Modifier
struct LogButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Bold", size: 14))
            .foregroundColor(themeColour)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .background(Color(textColour))
            .cornerRadius(50)
            .shadow(color: textColour, radius: 5)
    }
}

extension View {
    func withLogButtonFormatting() -> some View {
        modifier(LogButtonModifier())
    }
}

// MARK: Widget Text Modifier
struct SetTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("MontserratRoman-Regular", size: 14))
            .foregroundColor(textColour)
            .frame(height: 60)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(widgetLogRowColour))
            .cornerRadius(5)
    }
}

extension View {
    
    func withSetTextFormatting() -> some View {
        modifier(SetTextModifier())
    }
}

// MARK: Set Row Modifier
struct SetRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(textColour)
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(Color(themeColour))
            .cornerRadius(30)
            .shadow(radius: 10)
            .cornerRadius(30)
            .shadow(color: themeColour, radius: 5)
            .padding(.top, 5)
            .padding(.leading)
            .padding(.trailing)
    }
}

extension View {
    
    func withSetRowFormatting() -> some View {
        modifier(SetRowModifier())
    }
}
