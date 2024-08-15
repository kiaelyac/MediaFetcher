//
//  MediaPlayerView.swift
//  SadadAssignment
//
//  Created by kiarash on 8/13/24.
//

import SwiftUI

struct MediaPlayerView: View {
    let media: Media
    var body: some View {
            VStack {
                Text(media.type.convertToMediaType.mediaLogText(mediaLink: media.mediaLink))
                    .multilineTextAlignment(.trailing)
            }
            .navigationTitle("Media Player")
            .onAppear(perform: {
                print(media.type.convertToMediaType.mediaLogText(mediaLink: media.mediaLink))
            })
    }
}

#Preview {
    MediaPlayerView(media: Media(title: "", type: "", previewLink: "", mediaLink: ""))
}
