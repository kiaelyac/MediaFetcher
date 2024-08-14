//
//  MediaPlayerView.swift
//  SadadAssignment
//
//  Created by kiarash on 8/13/24.
//

import SwiftUI

struct MediaPlayerView: View {
    let mediaType: MediaType
    let mediaLink: String
    var body: some View {
        VStack {
            Text(mediaType.mediaLogText(mediaLink: mediaLink))
                .multilineTextAlignment(.trailing)
                
                
        }
        .onAppear(perform: {
            print(mediaType.mediaLogText(mediaLink: mediaLink))
        })
    }
}

#Preview {
    MediaPlayerView(mediaType: .video, mediaLink: "efewfewfwefwedscSUDHCWCEIUCUWCG9WEGCG9EQWCW89ECG98EWGC W89EGC8G9EW98GC 98CE8CW")
}
