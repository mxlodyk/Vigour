//  HomeView.swift
//  Vigour
//  Created by Melody Flavel on 4/7/2024.

import SwiftUI

// MARK: Home View
struct HomeView: View {
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @EnvironmentObject var hm: HealthManager
    
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
                    .withHeading1Formatting()
                Spacer()
                NavigationLink(destination: MenuView().environmentObject(edp).environmentObject(hm)) {
                    Image("OnButton")
                }
            }
            .withEdgePadding()
        }
    }
}
