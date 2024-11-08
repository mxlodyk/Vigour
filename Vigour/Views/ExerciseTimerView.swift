//  ExerciseTimerView.swift
//  Vigour
//  Created by Melody Flavel on 20/7/2024.

import SwiftUI

struct ExerciseTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var to : CGFloat = 0
    @State var count: Int
    @State var initialCount: Int
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var restTime: String
    var restUnit: String
    
    init(restTime: String, restUnit: String) {
        self.restTime = restTime
        self.restUnit = restUnit
        
        var initialValue: Int = 10
        
        // Convert restTime to seconds based on restUnit
        if let restTimeValue = Int(restTime) {
            if restUnit.lowercased() == "minutes" {
                initialValue = restTimeValue * 60
            } else if restUnit.lowercased() == "seconds" {
                initialValue = restTimeValue
            }
        }
        _count = State(initialValue: initialValue)
        _initialCount = State(initialValue: initialValue)
        _to = State(initialValue: CGFloat(_count.wrappedValue))

        }
    
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
                Button(action: {
                    self.count = 0
                    withAnimation(.default) {
                        self.to = 0
                    }
                }) {
                    Image("SkipButton")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            } // End of background ZStack view.
        .navigationBarBackButtonHidden()
        .onReceive(self.time) { (_) in
            if self.count != 0 {
                self.count -= 1
                withAnimation(.default) {
                    self.to = CGFloat(self.count) / CGFloat(self.initialCount)
                }
            } else {
                withAnimation(.default) {
                    self.to = 1
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        // Invalidate timer.
        .onDisappear {
            self.time.upstream.connect().cancel()
        }
        }
    }
