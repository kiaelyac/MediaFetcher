//
//  MediaList.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Foundation

struct Media: Codable, Hashable {
    let title, type: String
    let previewLink: String
    let mediaLink: String
}

typealias MediaList = [Media]

extension MediaList {
   static let mockData = [
        Media(title: "Text 1", type: "image", previewLink: "https://wallpapershome.com/images/pages/ico_v/25389.jpg", mediaLink: "https://wallpapershome.com/images/pages/ico_v/25389.jpg"),
        Media(title: "Text 2", type: "video", previewLink: "https://wallpapershome.com/images/pages/ico_v/25389.jpg", mediaLink: "https://cdn.coverr.co/videos/coverr-palm-tree-landscape-3016/1080p.mp4"),
        Media(title: "Text 3", type: "image", previewLink: "https://wallpapershome.com/images/pages/ico_v/25389.jpg", mediaLink: "https://wallpapershome.com/images/pages/ico_v/25389.jpg")
    ]
}
