//  ProgramViewModel.swift
//  Vigour
//  Created by Melody Flavel on 7/7/2024.

import Foundation
import SwiftUI

class ProgramViewModel: ObservableObject {
    
    @Published var programs: [ProgramModel] = []
    
    init() {
        self.programs = DataProvider.getPrograms()
    }
    
    func addProgram(_ program: ProgramModel) {
        var program = program
        programs.append(program)
        DataProvider.addProgram(programModel: &program)
    }
}
