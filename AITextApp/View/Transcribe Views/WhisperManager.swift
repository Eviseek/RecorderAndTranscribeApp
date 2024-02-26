//
//  WhisperManager.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 26.02.2024.
//

import Foundation

class WhisperManager {
    
    static let shared = WhisperManager()
    
    var secretKey = "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"
    
    private init() {}
    
    
    func fetchData(recording: Recording, completion: @escaping () -> ()) {
        
        let url = URL(string: "https://api.openai.com/v1/audio/transcriptions")
        
        guard let url = url else { return }
        
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(secretKey)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type") //TODO: add boundary?
        
        
        var data = Data()
        
        //data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        //data.append("Content-Disposition:form-data; name=\"audiofile\"; filename=\"\(recording.url?.lastPathComponent)\"\r\n".data(using: .utf8)!)
      //  data.append("Content-Type: audiofile/m4a\r\n\r\n".data(using: .utf8)!)
        data.append("file=\(recording.url)".data(using: .utf8)!)
        data.append("model=whiper-1".data(using: .utf8)!)
     //  data.append(image.pngData()!)
    //    data.append("Content-Disposition:form-data; name=\"audiofile\"; filename=\"audio.m4a\"\r\n\r\n")
        
     //   request.httpBody?.append(data)
    
        
        URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
            guard let data = data else {
                //failure
                completion()
                return
            }
            
            print("my returned data are \(data)")
            
            do {
              //  let transcription = try JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: data)
                //return data
            } catch {
                //return error
            }
            
            completion()
            
        }
        .resume()
    }
    
    
}
