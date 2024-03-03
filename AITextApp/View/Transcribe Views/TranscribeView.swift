//
//  TranscribeView.swift
//  AITextApp
//
//  Created by Eva Chlpikova on 25.02.2024.
//

import SwiftUI

struct TranscribeView: View {
    
    @ObservedObject var transcribeViewModel = TranscribeViewModel()
    
    var selectedRecording: Recording
    
    @State private var text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi scelerisque luctus velit. Donec quis nibh at felis congue commodo. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Mauris elementum mauris vitae tortor. Pellentesque arcu. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Pellentesque arcu. Curabitur ligula sapien, pulvinar a vestibulum quis, facilisis vel sapien. Vestibulum erat nulla, ullamcorper nec, rutrum non, nonummy ac, erat. Maecenas aliquet accumsan leo. Pellentesque arcu. Nulla est. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Duis ante orci, molestie vitae vehicula venenatis, tincidunt ac pede. Nulla non arcu lacinia neque faucibus fringilla. Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Nullam at arcu a est sollicitudin euismod. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Donec vitae arcu. Morbi leo mi, nonummy eget tristique non, rhoncus non leo. Quisque tincidunt scelerisque libero. Phasellus enim erat, vestibulum vel, aliquam a, posuere eu, velit. Nulla non lectus sed nisl molestie malesuada. Etiam ligula pede, sagittis quis, interdum ultricies, scelerisque eu. Phasellus et lorem id felis nonummy placerat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim."
    
    var body: some View {
        VStack {
            
            PlayerView()
            
            Spacer()
            
            VStack {
                TextEditor(text: $text)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .onAppear {
                transcribeViewModel.setSelectedRecording(selectedRecording)
            }
        }
    }
}

struct PlayerView: View {
    
    @State private var value = 0.0
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Recording 1")
                    .foregroundStyle(.gray)
                Button {
                    //
                } label: {
                    Image(systemName: "pencil.and.scribble")
                }
            }
            
            HStack {
                Button {
                    //play or stop
                } label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(.white)
                            .shadow(color: Color(.systemGray4), radius: 5)
                            .frame(width: 30, height: 30, alignment: .center)
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16, alignment: .center)
                    }
                }
                
                Spacer()
                
                Text(String(value))
                Slider(value: $value, in: 0.0...100.0)
            }
            .padding(.horizontal, 15)
            
            
        }
        .padding(.vertical, 15)
        .background(Color(.systemGray5))
    }
    
}

#Preview {
    TranscribeView(selectedRecording: Recording.TEST_DATA[0])
}
