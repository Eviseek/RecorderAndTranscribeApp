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
    
    //
    let defaults = UserDefaults.standard
    var numberOfRecordings = 1
    
    var recordings = [Recording]()
    
    init() {
        
        updateNumberOfRecordings()
        
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
    
    private func setupRecorder() { //would it be better to do throws func?
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
    
    func startRecording() {
        print("starting recording")
        setupAudioSession()
        setupRecorder()
        audioRecorder?.record()
    }
    
    func stopRecording() {
        print("stopping recording")
        audioRecorder?.stop()
       // generateRecordingInfo(<#T##fileName: String##String#>)
    }
    
    func playRecording(for fileName: String) {
        
        let url = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)?.appendingPathComponent("MyRecording.m4a")
        guard let url = url else {
            print("failed to get url")
            return
        }
        
        do {
            print("recording starting")
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()

            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer.play()
            
        } catch _ {
            print("!!! something went wrong, playRecording failed")
        }
        
    }
    
    func getGenericFileName() -> String {
        
        return ("NewRecording\(getNumberOfRecordings())")
        
    }
    
    private func updateNumberOfRecordings() {
        
        numberOfRecordings += 1
        defaults.set("numberOfRecordings", forKey: String(numberOfRecordings))
        
    }
    
    private func getNumberOfRecordings() -> Int {
        return defaults.value(forKey: "numberOfRecordings") as? Int ?? 0
    }
    
    func generateRecordingInfo(_ fileName: String) {
        
        let url = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)?.appendingPathComponent("MyRecording.m4a")
        guard let url = url else {
            print("failed to get url")
            return
        }
        
        do {
            // Get creation date
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: url.path(percentEncoded: false)) //false?
            guard let creationDate = fileAttributes[.creationDate] as? Date else { return }
            print("Recording Creation Date: \(creationDate)")
            
            
            // Calculate total duration
            let audioFile = try AVAudioFile(forReading: url)
            let durationInSeconds = Double(audioFile.length) / audioFile.fileFormat.sampleRate
            print("Recording Duration: \(durationInSeconds) seconds")
            
            createAndAppendRecording(fileName: fileName, creationDate: creationDate, durationSecs: durationInSeconds)
            
        } catch {
            print("something went wrong")
        }
        
    }
    
    func createAndAppendRecording(fileName: String, creationDate: Date, durationSecs: Double) {
        
        let title = fileName.replacingOccurrences(of: "-", with: " ")
        let recording = Recording(title: title, fileName: fileName, date: creationDate, durationSec: durationSecs)
        
        recordings.append(recording)
        
    }
    
    
}
