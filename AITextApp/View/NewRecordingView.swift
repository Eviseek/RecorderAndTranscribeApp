//
//  NewRecordingView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import SwiftUI

struct NewRecordingView: View {
    
    @EnvironmentObject var avAudioManager: AVAudioManager
    @EnvironmentObject var recordingsManager: RecordingsManager
    
    @ObservedObject var stopwatchManager = StopWatchManager()
    
    @Environment (\.dismiss) var dismiss
    
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .bold()
                .padding(.top, 30)
                .padding(.bottom, 5)
            Text(stopwatchManager.formattedTimeElapsed)
                .font(.system(size: 13))
                .foregroundStyle(.gray)
                .padding(.bottom, 15)
            
            Button {
                avAudioManager.stopRecording { url in
                    recordingsManager.appendNewRecording(url: url)
                }
                stopwatchManager.stopTimer()
                dismiss()
            } label: {
                ZStack {
                    Circle()
                        .fill(.gray)
                        .frame(width: 50, height: 50)
                    Circle()
                        .fill(.white)
                        .frame(width: 45, height: 45)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.red)
                        .frame(width: 20, height: 20)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    NewRecordingView(title: "New Recording 1")
        .environmentObject(AVAudioManager.shared)
        .environmentObject(RecordingsManager())
}
