//
//  RecordingItemView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 18.02.2024.
//

import SwiftUI

struct RecordingItemView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("New Recording 1")
                    .font(.system(size: 16))
                    .bold()
                Text("1. 2. 2024")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Button {
                    //TODO: transcribe view
                } label: {
                    HStack {
//                        Image(systemName: "text.quote")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 15, height: 15)
                        Text("Transcribe")
                            .foregroundStyle(.blue)
                            .font(.system(size: 16))
                    }
                }

                Text("25:10")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
        }
        //.padding(.horizontal, 10)
    }
}

#Preview {
    RecordingItemView()
}
