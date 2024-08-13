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
        
    NavigationStack {
        ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(mediaListViewModel.mediaList, id: \.title) { media in
                        MediaItemView(previewLink: media.previewLink, title: media.title)
                    }
                }
            }
            .navigationTitle("Media List")
            .overlay {
                if mediaListViewModel.isLoading {
                    ProgressView()
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
