//
//  AVAudioManager.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import Foundation
import AVFoundation

class AVAudioManager: ObservableObject {
    
    static let shared = AVAudioManager()
    
    private var audioSession: AVAudioSession?
    private var audioRecorder: AVAudioRecorder?
    
    private var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    private var audioState: AudioState = .playing
    
    private init() {
        
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
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
    
    private func setupRecorder(fileName: String) { //would it be better to do throws func?
        
        let recordingSettings: [String : Any] = [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(fileName).m4a")
        
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
    
    func startRecording(_ fileName: String) {
        
        print("starting recording")
        setupAudioSession()
        setupRecorder(fileName: fileName)
        audioRecorder?.record()
        
    }
    
    func stopRecording(completion: (URL?) -> ()) {
        
        print("stopping recording")
        let url  = audioRecorder?.url
        audioRecorder?.stop()
        completion(url)
        
    }
    
    func pauseRecording() {
        
        print("should pause")
        audioPlayer.pause()
        
    }
    
    func playOrResumeRecording(for fileName: String, _ url: URL? = nil, state: AudioState) {
        
        if state == .start {
            playRecording(for: fileName)
        } else if state == .paused {
            resumeRecording()
        }
    
    }
    
    func resumeRecording() {
        audioPlayer.play()
    }
    
    private func playRecording(for fileName: String, _ url: URL? = nil) {
        
        print("should play")
        
        let url = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)?.appendingPathComponent("\(fileName)")
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
    
    func deleteRecording(fileName: String, _ url: URL? = nil, completion: (Bool) -> ()) {
        
        print("should delete")
        
        let url = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)?.appendingPathComponent("\(fileName)")
        guard let url = url else {
            print("failed to get url")
            completion(false)
            return
        }
        
        do {
            
            let fileManager = FileManager.default
            try fileManager.removeItem(at: url)
            
            completion(true)
            
        } catch {
            
            print("!!! something went wrong, deleteRecording()")
            completion(false)
            
        }
        
        completion(false)
        
    }

    
    func getRecordingInformation(_ url: URL) -> Recording? {
        
        do {
            // Get filename
            let fileName = url.lastPathComponent
            
            // Generate title
            var title = fileName.toTitle()
            
            // Get creation date
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: url.path(percentEncoded: false)) //false?
            guard let creationDate = fileAttributes[.creationDate] as? Date else { return nil }
            print("Recording Creation Date: \(creationDate)")
            
            
            // Calculate total duration
            let audioFile = try AVAudioFile(forReading: url)
            let durationInSeconds = Double(audioFile.length) / audioFile.fileFormat.sampleRate
            print("Recording Duration: \(durationInSeconds) seconds")
            
            // And finally, return information
            return Recording(title: title, fileName: fileName, date: creationDate, durationSec: durationInSeconds, url: url)
            
        } catch {
            print("something went wrong")
        }
        
        return nil
        
    }
    
    
}
