//  HomeView.swift
//  Vigour
//  Created by Melody Flavel on 4/7/2024.

import SwiftUI

// MARK: Home View
struct HomeView: View {
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                DumbbellVideoPlayerView(videoName: "Dumbbell Animation")
                    .frame(width: 350, height: 350)
                    .edgesIgnoringSafeArea(.all)
                Spacer()
                Text("VIGOUR")
                    .withTitleFormatting()
                Spacer()
                NavigationLink(destination: MenuView()) {
                    Image("OnButton")
                }
            }
            .withEdgePadding()
        }
    }
}
