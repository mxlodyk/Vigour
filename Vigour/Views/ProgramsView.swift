//  ProgramsView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

// MARK: Programs View
struct ProgramsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingBottomSheet = false
    
    @EnvironmentObject var edp: ExerciseDataProvider
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(edp.programs) { program in
                        ProgramRowView (program: program)
                            .contextMenu {
                                Button(action: {
                                    edp.deleteProgram(program)
                                }) {
                                    Text("Delete")
                                }
                            }
                    }
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
                AddProgramView().environmentObject(edp)
                    .presentationDetents([.fraction(0.2)])
            })
        }
    }
}
