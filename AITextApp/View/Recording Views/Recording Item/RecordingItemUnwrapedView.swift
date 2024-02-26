//
//  RecordingItemUnwrapedView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 24.02.2024.
//

import SwiftUI

struct RecordingItemUnwrapedView: View {
    
    @EnvironmentObject var avAudioManager: AVAudioManager
    @EnvironmentObject var recordingsManager: RecordingsManager
    
    @ObservedObject var timerManager = TimerManager()
    
    var recording: Recording
    
    @State private var time: Double = 0
    @State private var state: AudioState = .start
    @State private var isPresented = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
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
                        
                        VStack {
                            Text("Transcribe")
                                .foregroundStyle(.blue)
                                .font(.system(size: 16))
                        }
                        .onTapGesture {
                            isPresented = true
           
                        }
                        .navigationDestination(isPresented: $isPresented, destination: {
                            TranscribeView(selectedRecording: recording)
                        })

                        
                        
                    }
                    
                }
                
                VStack {
                    Slider(value: $timerManager.rawSecondsElapsed, in: 0...recording.durationSec)
                    HStack {
                        Text("\(timerManager.formattedTimeElapsed)")
                            .font(.caption)
                        Spacer()
                    }
                    .foregroundStyle(.gray)
                }
                .tint(.white)
                .disabled(true)
                .padding(.top, 10)
                
                HStack {
                    
                    VStack {
                        Image(systemName: "scribble")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .tint(.black)
                    }
                    
                    Spacer()
                    
                    if state == .start || state == .paused {
                        VStack {
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .tint(.black)
                        }
                        .onTapGesture {
                            avAudioManager.playOrResumeRecording(for: recording.fileName, state: state)
                            state = .playing
                            timerManager.pauseResumeTimer(isPaused: false)
                        }
                    } else {
                        VStack {
                            Image(systemName: "pause.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .tint(.black)
                        }
                        .onTapGesture {
                            avAudioManager.pauseRecording()
                            state = .paused
                            timerManager.pauseResumeTimer(isPaused: true)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        avAudioManager.deleteRecording(fileName: recording.fileName) { success in
                            if success {
                                recordingsManager.removeRecording(url: recording.url)
                            }
                        }
                    }
                    
                }
                .onAppear {
                    timerManager.setDuration(recording.durationSec)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                
            }
        }
    }
}

#Preview {
    RecordingItemUnwrapedView(recording: Recording.TEST_DATA[0])
        .environmentObject(AVAudioManager.shared)
        .environmentObject(RecordingsManager())
}
