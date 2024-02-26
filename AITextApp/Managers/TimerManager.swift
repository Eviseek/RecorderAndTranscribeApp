//
//  StopWatchManager.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import Foundation

class TimerManager: ObservableObject {
    
    private var timer = Timer()
    private var isPaused = false
    private var durationSecs = 0.0
    
    var timeHasPassed = false
    
    @Published var formattedTimeElapsed: String = "00:00:00"
    @Published var rawSecondsElapsed = 0.0
    
    init() {}
    
    private func formatIntoHMS(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        let seconds = Int(seconds) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func pauseResumeTimer(isPaused: Bool) {
            
            if !isPaused {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                    self.rawSecondsElapsed += 1
                    self.formattedTimeElapsed = self.formatIntoHMS(self.rawSecondsElapsed)
                    self.checkDuration(elapsedSecs: self.rawSecondsElapsed, durationSecs: self.durationSecs)
                })
            } else {
                timer.invalidate()
            }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func setDuration(_ durationSecs: Double) {
        self.durationSecs = durationSecs
        print("duration is \(durationSecs)")
    }
    
    private func checkDuration(elapsedSecs: Double, durationSecs: Double) {
        
        print("checking \(elapsedSecs)/\(durationSecs)")
        
        if elapsedSecs < durationSecs {
            timer.invalidate()
            timeHasPassed = true
        }
    }
    
}
