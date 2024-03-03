//
//  WhisperManager.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 26.02.2024.
//

import Foundation
import Alamofire

class WhisperManager: ObservableObject {
    
    static let shared = WhisperManager()
    
    var secretKey = ""
    
    private init() {}
    
    
    func fetchData(recording: Recording, completion: @escaping (WhisperResponse?, AFError?) -> ()) {
        
        print("fetch data")
        
        if recording.durationSec > 15 { //for testing purposes, so I don't send recording over 15 seconds
            print("recording too long")
            return
        }
        
        let url = URL(string: "https://api.openai.com/v1/audio/transcriptions")
        
        guard let url = url else { return }
        
        guard let recordingURL = recording.url else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(secretKey)",
            "Content-Type" : "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(recordingURL, withName: "file")
            multipartFormData.append(Data("whisper-1".utf8), withName: "model")
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: WhisperResponse.self) { response in
            print("my response is \(response.result)")
            completion(response.value, response.error)
        }
        
    }
    
    
}
