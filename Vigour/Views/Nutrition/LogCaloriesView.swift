//  LogCaloriesView.swift
//  Vigour
//  Created by Melody Flavel on 17/11/2024.

import SwiftUI

struct LogCaloriesView: View {
    
    @State var showingMealBottomSheet = false
    @State var showingFoodBottomSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Button(action: {
                        showingMealBottomSheet.toggle()
                    }) {
                        Text("Add Meal")
                            .withButtonFormatting()
                    }
                    .sheet(isPresented: $showingMealBottomSheet, content: {
                        AddMealView()
                            .presentationDetents([.fraction(0.6)])
                    })
                    Button(action: {
                        showingFoodBottomSheet.toggle()
                    }) {
                        Text("Add Food")
                            .withButtonFormatting()
                    }
                    .sheet(isPresented: $showingFoodBottomSheet, content: {
                        FoodSearchView()
                            .presentationDetents([.fraction(0.6)])
                    })
                }
            }
        }
        //.presentationDetents([.fraction(0.2), .fraction(0.3), .fraction(0.6)], selection: $detentSize)
        .presentationDetents([.fraction(0.2)])
    }
}

