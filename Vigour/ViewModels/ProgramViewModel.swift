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
    
    // Add Program
    func addProgram(_ program: ProgramModel) {
        var program = program
        programs.append(program)
        DataProvider.addProgram(programModel: &program)
    }
    
    // Delete Program
    func deleteProgram(_ program: ProgramModel) {
        if let index = programs.firstIndex(where: { $0.id == program.id}) {
            programs.remove(at: index)
        }
    }
}
