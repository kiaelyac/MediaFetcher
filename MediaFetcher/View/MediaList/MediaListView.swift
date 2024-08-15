//
//  ContentView.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import SwiftUI

struct MediaListView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject var mediaListViewModel = MediaListViewModel()
    var body: some View {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(mediaListViewModel.mediaList, id: \.title) { media in
                        
                        Button {
                            coordinator.push(.mediaPlayerView(media: media))
                        } label: {
                            MediaItemView(previewLink: media.previewLink, title: media.title, type: media.type.convertToMediaType)
                        }
                        .padding()
                    }
                }
            }
            .alert(mediaListViewModel.errorMessage, isPresented: $mediaListViewModel.receivedError, actions: {
                Button(action: {}, label: {
                    Text("Cancel")
                })
                Button(action: {
                    mediaListViewModel.getMediaList()
                }, label: {
                    Text("Load Again")
                })
            })
            .navigationTitle("Media List")
            .overlay {
                if mediaListViewModel.isLoading {
                    ProgressView()
                }
            }
        .onAppear(perform: {
            mediaListViewModel.getMediaList()
        })
    }
}

#Preview {
    MediaListView()
}
