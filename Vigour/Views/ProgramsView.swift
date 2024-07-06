//  ProgramsView.swift
//  Vigour
//  Created by Melody Flavel on 5/7/2024.

import SwiftUI

struct ProgramsView: View {
    
    @State var programs: [ProgramModel] = DataProvider.getPrograms()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(DataProvider.programs) { program in
                        ProgramListRowView(program: program)
                    }
                    Spacer()
                }
                .withEdgePadding()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProgramsView()
}
