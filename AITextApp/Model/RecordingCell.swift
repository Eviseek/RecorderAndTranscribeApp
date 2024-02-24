//
//  RecordingCell.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 24.02.2024.
//

import Foundation

struct RecordingCell {
    
    var isUnwraped: Bool
    var recording: Recording
    
    var id: String {
        return UUID().uuidString
    }
    
}


extension RecordingCell {
    
    static var TEST_DATA: [RecordingCell] =
    [
        RecordingCell(isUnwraped: false, recording: Recording(title: "My amazing recording", fileName: "My_amazing_recoding", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 120)),
        RecordingCell(isUnwraped: false, recording: Recording(title: "My great recording", fileName: "My_great_recoding", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 150)),
        RecordingCell(isUnwraped: false, recording: Recording(title: "My superb recording", fileName: "My_superb_recoding", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 500)),
        RecordingCell(isUnwraped: false, recording: Recording(title: "Recording 1", fileName: "Recoding_1", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 60)),
        RecordingCell(isUnwraped: false, recording: Recording(title: "Economics lecture", fileName: "Recoding_12", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 12000)),
    ]

}
