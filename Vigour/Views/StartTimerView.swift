//  StartTimerView.swift
//  Vigour
//  Created by Melody Flavel on 19/7/2024.

import SwiftUI

// MARK: Start Timer View
struct StartTimerView: View {
    
    //@State var start = false
    @State var to : CGFloat = 10
    @State var count = 10
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var navigateToInteractiveWorkoutView = false
    @EnvironmentObject var selectedWorkout: WorkoutEntity
    
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
            NavigationLink(destination: InteractiveWorkoutView().environmentObject(selectedWorkout), isActive: $navigateToInteractiveWorkoutView) {
                EmptyView()
            }
        } // End of background ZStack view.
        .navigationBarBackButtonHidden()
        .onReceive(self.time) { (_) in
            if self.count != 0 {
                self.count -= 1
                withAnimation(.default) {
                    self.to = CGFloat(self.count) / 10
                }
                print(self.to)
                print(self.count)
            } else {
                withAnimation(.default) {
                    self.to = 1
                    self.navigateToInteractiveWorkoutView = true
                }
            }
        }
    } // End of body view.
} // End of StartTimerView view.
