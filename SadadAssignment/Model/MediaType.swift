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
    
    func mediaLogText(mediaLink: String) -> String {
        switch self {
        case .video:
            return "پخش ویدیو با لینک:\(mediaLink)"
        case .image:
            return "نمایش تصویر با لینک:\(mediaLink)"
        case .other:
            return "عدم وجود ویدیو با لینک:\(mediaLink)"
        }
    }
}
