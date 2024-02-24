//
//  ContentView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

//TODO: close all cells when another opened -> only one cell at the time should be opened

import SwiftUI

struct AllRecordingsView: View {
    
    @State private var recordingSheetPresented = false
    @State private var shouldRefresh = false
    
    @EnvironmentObject var avAudioManager: AVAudioManager
    @EnvironmentObject var recordingsManager: RecordingsManager
    
    @StateObject var recordingCellsManager = RecordingCellsManager()
    
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
                    ForEach(recordingsManager.recordings, id: \.fileName) { recording in
                        RecordingItemView(recording: recording, recordingCell: RecordingCell.TEST_DATA[0])
                       // append()
                    }
                }
                .padding(.horizontal, -15)
                .listStyle(.inset)
            }
            .padding(.horizontal, 15)

            
            VStack {
                Button {
                    avAudioManager.startRecording(recordingsManager.getGenericFileName())
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
                    NewRecordingView(title: recordingsManager.getGenericFileName().toTitle())
                        .presentationDetents([.height(150)])
                }
                .padding(.top, 15)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
        }
    }
    
    func append() {
        recordingCellsManager.appendNewCell(recordingCell: RecordingCell.TEST_DATA[0])
    }
    
}

#Preview {
    AllRecordingsView()
        .environmentObject(AVAudioManager.shared)
        .environmentObject(RecordingsManager())
}
