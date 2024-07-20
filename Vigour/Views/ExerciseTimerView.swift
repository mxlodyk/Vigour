//  ExerciseTimerView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct ExerciseTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var to : CGFloat = 10 // Edit
    @State var count = 10 // Edit
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var restTime: String
    var restUnit: String
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    // MARK: Empty Circle Stroke
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    // MARK: Filled Circle Stroke
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.theme, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                    VStack {
                        Text("\(self.count)")
                            .withTimerTextFormatting()
                    }
                }
            }
            } // End of background ZStack view.
        .navigationBarBackButtonHidden()
        .onReceive(self.time) { (_) in
            if self.count != 0 {
                self.count -= 1
                withAnimation(.default) {
                    self.to = CGFloat(self.count) / 10
                }
            } else {
                withAnimation(.default) {
                    self.to = 1
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        }
    }
