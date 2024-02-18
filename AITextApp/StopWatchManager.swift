//
//  StopWatchManager.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import Foundation

class StopWatchManager: ObservableObject {
    
    private var secondsElapsed = 0.0
    private var timer = Timer()
    
    @Published var formattedTimeElapsed: String = "00:00:00"
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.secondsElapsed += 1
            self.formattedTimeElapsed = self.formatIntoHMS(self.secondsElapsed)
        })
    }
    
    private func formatIntoHMS(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        let seconds = Int(seconds) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
}
