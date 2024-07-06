//  ProgramsView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

struct ProgramsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingBottomSheet = false
    @StateObject var programViewModel = ProgramViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(programViewModel.programs) { program in
                        ProgramListRowView(program: program)
                    }
                    Spacer()
                }
                .withEdgePadding()
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("BackButton")
                        .iconStyle()
                },
                trailing:
                Button(action: {
                    showingBottomSheet.toggle()
                }) {
                    Image("AddButton")
                        .iconStyle()
                })
            .sheet(isPresented: $showingBottomSheet, content: {
                AddProgramView(programViewModel: programViewModel)
                    .presentationDetents([.fraction(0.2 )])
            })
        }
    }
}
