//
//  AITextAppApp.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import SwiftUI

@main
struct AITextAppApp: App {
    
    @StateObject var avAudioManager = AVAudioManager.shared
    @StateObject var recordingsManager = RecordingsManager()
    
    var body: some Scene {
        WindowGroup {
            AllRecordingsView()
                .environmentObject(avAudioManager)
                .environmentObject(recordingsManager)
        }
    }
}
