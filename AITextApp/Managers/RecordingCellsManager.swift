//
//  RecordingItemViewModel.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 24.02.2024.
//

import Foundation

class RecordingCellsManager: ObservableObject {
    
    @Published var isUnwraped: Bool = false
    
    @Published var recordingCells: [RecordingCell]
    
    init() {
        recordingCells = [RecordingCell]()
    }
    
    func appendNewCell(recordingCell: RecordingCell) {
        recordingCells.append(recordingCell)
    }

    
}
