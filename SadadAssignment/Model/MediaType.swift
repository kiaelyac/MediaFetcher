//
//  MediaType.swift
//  SadadAssignment
//
//  Created by kiarash on 8/13/24.
//

import Foundation

enum MediaType: String {
    case video = "video"
    case image = "image"
    case other
    
    var isPlayable: Bool {
        switch self {
        case .video:
            true
        case .image:
            false
        case .other:
            false
        }
    }
}
