//
//  RecordingItemView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import SwiftUI

struct RecordingItemView: View {
    
    @EnvironmentObject var recordingsManager: RecordingsManager
    
    @State private var showUnwraped = false
    
    let recording: Recording
  
    let recordingCell: RecordingCell
    
   // @Binding var shouldRefresh: Bool
    
    var body: some View {
            if !showUnwraped {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recording.title)
                            .font(.system(size: 16))
                            .bold()
                        Text(recording.date.toStrDate())
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Button {
                            //TODO: transcribe view
                        } label: {
                            Text("Transcribe")
                                .foregroundStyle(.blue)
                                .font(.system(size: 16))
                        }
                        
                        Text(recording.durationSec.toHours())
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                }
                .onTapGesture {
                    showUnwraped.toggle()
                    refreshArray()
                }
            } else {
                RecordingItemUnwrapedView(recording: recording)
            }
    }

    func refreshArray() {
        recordingsManager.refreshArray()
    }
    
}

#Preview {
    RecordingItemView(recording: Recording.TEST_DATA[0], recordingCell: RecordingCell.TEST_DATA[0])
        .environmentObject(RecordingsManager())
}
