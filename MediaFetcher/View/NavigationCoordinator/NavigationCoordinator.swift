//
//  NavigationCoordinator.swift
//  MediaFetcher
//
//  Created by kiarash on 8/15/24.
//

import SwiftUI

enum Page: Hashable, Equatable {
    
    case mediaList
    case mediaPlayerView(media: Media)
    

}

class NavigationCoordinator: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    
    func push(_ page: Page) {
        navigationPath.append(page)
    }
    func pop(_ page: Page) {
        navigationPath.removeLast()
    }
    func popTooRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .mediaList:
            MediaListView()
        case .mediaPlayerView(let media):
            MediaPlayerView(media: media)
        }
    }
}
