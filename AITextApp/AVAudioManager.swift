//
//  AVAudioManager.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import Foundation
import AVFoundation

class AVAudioManager: ObservableObject {
    
    var audioSession: AVAudioSession?
    var audioRecorder: AVAudioRecorder?
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    init() {
        
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
              //  self.setupAudioSession()
              //  self.setupRecorder()
                print("granted")
            } else {
                // not
                print("!!!! error, permissions not granted")
            }
        }
    }
    
    private func setupAudioSession() { //would it be better to do throws func?
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            // error
            print("!!!! something went wrong, setupAudioSession")
        }
    }
    
    private func setupRecorder(with title: String) { //would it be better to do throws func?
        let recordingSettings: [String : Any] = [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("MyRecording.m4a")
        
        print("this is my path \(audioFilename)")
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recordingSettings)
            print("prepared to record")
            audioRecorder?.prepareToRecord()
        } catch {
            //error
            print("!!!! something went wrong, setupRecorder")
        }
    }
    
    func startRecording(title: String) {
        print("starting recording")
        setupAudioSession()
        setupRecorder(with: title)
        audioRecorder?.record()
    }
    
    func stopRecording() {
        print("stopping recording")
        audioRecorder?.stop()
       // audioRecorder = nil
    }
    
    func playRecording(_ fileName: String) {
        
        do {
            let url = Bundle.main.url(forResource: "MyRecording", withExtension: "m4a")!
            audioPlayer = try AVAudioPlayer(contentsOf: url)
           // audioPlayer.numberOfLoops = 0 // loop count, set -1 for infinite
           // audioPlayer?.volume = 1
            audioPlayer.prepareToPlay()

            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer.play()
        } catch _ {
            print("!!! something went wrong, playRecording failed")
        }
        
    }
    
    
}
