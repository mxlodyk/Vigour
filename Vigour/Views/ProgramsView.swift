//  ProgramsView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

// MARK: Programs View
struct ProgramsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingBottomSheet = false
    
    @StateObject var cd = CoreDataProvider()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(cd.programs) { program in
                        ProgramRowView (program: program)
                            .contextMenu {
                                Button(action: {
                                    cd.deleteProgram(program)
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
                AddProgramView(cd: cd)
                    .presentationDetents([.fraction(0.2)])
            })
        }
    }
}
