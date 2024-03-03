//
//  Recording.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 19.02.2024.
//

import Foundation

struct Recording {
    
    var title: String
    var fileName: String
    var date: Date
    var durationSec: Double
    var url: URL?
    
    
}

extension Recording {
    
    static var TEST_DATA: [Recording] =
    [
        Recording(title: "My amazing recording", fileName: "My_amazing_recoding", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 120),
        Recording(title: "My great recording", fileName: "My_great_recoding", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 150),
        Recording(title: "My superb recording", fileName: "My_superb_recoding", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 500),
        Recording(title: "Recording 1", fileName: "Recoding_1", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 60),
        Recording(title: "Economics lecture", fileName: "Recoding_12", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 12000),
        Recording(title: "My amazing recording", fileName: "Recoding_11", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 120),
        Recording(title: "My great recording", fileName: "Recoding_2", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, durationSec: 150),
        Recording(title: "My superb recording", fileName: "Recoding_3", date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, durationSec: 500),
        Recording(title: "Recording 1", fileName: "Recoding_4", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, durationSec: 60),
        Recording(title: "Economics lecture", fileName: "Recoding_5", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, durationSec: 12000),
        Recording(title: "My amazing recording", fileName: "Recoding_6", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, durationSec: 120),
        Recording(title: "My great recording", fileName: "Recoding_7", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, durationSec: 150),
        Recording(title: "My superb recording", fileName: "Recoding_8", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, durationSec: 500),
        Recording(title: "Recording 1", fileName: "Recoding_9", date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, durationSec: 60),
        Recording(title: "Economics lecture", fileName: "Recoding_10", date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, durationSec: 12000)
    ]

}
