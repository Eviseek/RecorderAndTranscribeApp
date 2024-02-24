//
//  RecordingsManager.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 24.02.2024.
//

import Foundation

class RecordingsManager: ObservableObject {
    
    @Published var recordings: [Recording]
    
    private let defaults = UserDefaults.standard
    private var numberOfRecordings = 1
    
 //   @Published private var shouldBeOpened = false
    
    init() {
        
        recordings = Recording.TEST_DATA
        
        numberOfRecordings = getNumberOfRecordings()
        fetchAllRecordings()
        
    }
    
    private func fetchAllRecordings() {
        
        recordings = [Recording]() //TODO: delete and leave the fetch instead of test
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
    
            // get information of each recording and append it to array
            for fileURL in fileURLs {
                appendNewRecording(url: fileURL)
            }
            
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        
    }
    
//    func checkIfOpened() {
//        if alreadyOpened
//    }
    
    func appendNewRecording(url: URL?) {
        
        guard let url = url else { return }
        
        print("wanna append")
        
        if let recording = AVAudioManager.shared.getRecordingInformation(url) { //getting info about the recording - name, filename, duration, date
            recordings.append(recording)
            updateNumberOfRecordings() //
        }
        
        sortRecordings()

    }
    
    func removeRecording(url: URL?) {
        
        guard let url = url else { return }
        
        if let index = recordings.firstIndex(where: { $0.url == url }) {
            recordings.remove(at: index)
        }
        
    }
    
    func refreshArray() { //deleting and setting array again to make a "refresh" of sort
        print("refreshing the array")
        let recordingsArr = recordings
        recordings = [Recording]()
        recordings = recordingsArr
    }
    
    private func sortRecordings() {
        
        recordings.sort { ($0).date.compare($1.date) == .orderedDescending }
        
    }
    
    private func getNumberOfRecordings() -> Int {
        
        return defaults.value(forKey: "numberOfRecordings") as? Int ?? 1
        
    }
    
    func getGenericFileName() -> String {
        
        return ("New_Recording_\(numberOfRecordings)")
        
    }
    
    private func updateNumberOfRecordings() {
        
        numberOfRecordings += 1
        print("updating recordings to \(numberOfRecordings)")
        defaults.set("numberOfRecordings", forKey: String(numberOfRecordings))
        
    }
    
}
