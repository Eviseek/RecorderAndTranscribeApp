//
//  Extensions.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 24.02.2024.
//

import Foundation

extension Date {
    
    func toStrDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MM. yyyy"
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
}


extension Double {
    
    func toHours() -> String {
        var seconds = self
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        let seconds2 = Int(seconds) % 60
        
        if hours == 0 {
            return String(format:"%02i:%02i", minutes, seconds2)
        } else {
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds2)
        }
    }
    
}

extension String {
    
    func toTitle() -> String {
        var title = self.replacingOccurrences(of: "_", with: " ")
        title = title.replacingOccurrences(of: ".m4a", with: "")
        print("my title is \(title)")
        return title
    }
    
}
