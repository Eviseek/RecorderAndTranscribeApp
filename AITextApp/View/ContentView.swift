//
//  ContentView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var recordingSheetPresented = false
    
    @EnvironmentObject var avAudioManager: AVAudioManager
    
    var body: some View {
        VStack {
            
            Group {
                Text("All Recordings")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                Divider()
                
                List {
                    RecordingItemView()
                    RecordingItemView()
                    RecordingItemView()
                    RecordingItemView()
                    RecordingItemView()
                }
                .padding(.horizontal, -15)
                .listStyle(.inset)
            }
            .padding(.horizontal, 15)
            
            Button {
                avAudioManager.playRecording("NewRecording1")
            } label: {
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }

            
            VStack {
                Button {
                    avAudioManager.startRecording(title: "NewRecording1")
                    recordingSheetPresented.toggle()
                } label: {
                    ZStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 50, height: 50)
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                        Circle()
                            .fill(.red)
                            .frame(width: 40, height: 40)
                    }
                }
                .sheet(isPresented: $recordingSheetPresented) {
                    NewRecordingView()
                        .presentationDetents([.height(150)])
                }
                .padding(.top, 15)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AVAudioManager())
}
