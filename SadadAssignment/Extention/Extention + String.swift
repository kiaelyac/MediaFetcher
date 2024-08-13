//
//  Extention + String.swift
//  SadadAssignment
//
//  Created by kiarash on 8/13/24.
//

import Foundation

extension String {
    
    var convertToMediaType: MediaType {
        guard let mediaType = MediaType(rawValue: self) else { return .other }
        return mediaType
    }
}
