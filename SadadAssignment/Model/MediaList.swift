//
//  MediaList.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Foundation


struct Media: Codable {
    let title, type: String
    let previewLink: String
    let mediaLink: String
}

typealias MediaList = [Media]

