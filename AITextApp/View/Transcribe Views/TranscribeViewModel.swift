//
//  TranscribeViewModel.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 26.02.2024.
//

import Foundation

class TranscribeViewModel: ObservableObject {
    
    private var selectedRecording: Recording? = nil
    
    init() {}
    
    func setSelectedRecording(_ recording: Recording) {
        
        self.selectedRecording = recording
        
        startTranscribing()
        
    }
    
    private func startTranscribing() {
        
        guard let selectedRecording = selectedRecording else { return }
        
//        WhisperManager.shared.fetchData(recording: selectedRecording) { transcription, error in
//            if error != nil {
//                print("Something went wrong")
//                return
//            }
//            if let transcription = transcription {
//                print("this is my transcription \(transcription.text)")
//            }
//        }
    }
    
}
