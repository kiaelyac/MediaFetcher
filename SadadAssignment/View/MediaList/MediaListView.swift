//
//  ContentView.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import SwiftUI

struct MediaListView: View {
    @StateObject var mediaListViewModel = MediaListViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(mediaListViewModel.mediaList, id: \.title) { media in
                    MediaItemView(previewLink: media.previewLink, title: media.title)
                }
            }
        }

        .onAppear(perform: {
            mediaListViewModel.getMediaList()
        })
        .padding()
    }
}

#Preview {
    MediaListView()
}
