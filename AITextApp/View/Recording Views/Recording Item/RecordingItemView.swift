//
//  RecordingItemView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import SwiftUI

struct RecordingItemView: View {
    
    @EnvironmentObject var recordingsManager: RecordingsManager
    @EnvironmentObject var avAudioManager: AVAudioManager
    
    let cellFileName: String
    
    @State private var isPresented = false
    
    private var cellIndex: Int {
      //  return RecordingCell.TEST_DATA.firstIndex(where: { $0.id == cellId }) ?? 0
        print("my id is \(cellFileName)")
        return recordingsManager.recordingCells.firstIndex(where: { $0.recording.fileName == cellFileName }) ?? 0
    }
    
    var body: some View {
            
            if !recordingsManager.recordingCells[cellIndex].isUnwraped {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recordingsManager.recordingCells[cellIndex].recording.title)
                            .font(.system(size: 16))
                            .bold()
                        Text(recordingsManager.recordingCells[cellIndex].recording.date.toStrDate())
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Button {
                            isPresented = true
                        } label: {
                            Text("Transcribe")
                                .foregroundStyle(.blue)
                                .font(.system(size: 16))
                        }
                        .navigationDestination(isPresented: $isPresented) {
                            TranscribeView(selectedRecording: recordingsManager.recordingCells[cellIndex].recording)
                        }
                        
                        Text(recordingsManager.recordingCells[cellIndex].recording.durationSec.toHours())
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                }
                .onTapGesture {
                    avAudioManager.pauseRecording()
                    recordingsManager.refreshRecordingCells()
                    recordingsManager.setUnwrappedFor(cellIndex)
                }
            } else {
                RecordingItemUnwrapedView(recording: recordingsManager.recordingCells[cellIndex].recording)
                // .scaledToFit()
            }
    }
    
}

#Preview {
    RecordingItemView(cellFileName: RecordingCell.TEST_DATA[0].recording.fileName)
        .environmentObject(RecordingsManager())
        .environmentObject(AVAudioManager.shared)
}
