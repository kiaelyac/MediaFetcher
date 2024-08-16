//
//  NetworkRequestError.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Foundation

enum NetworkRequestError: Error {
    case invalidRequest(description: String)
    case badRequest(description: String)
    case unauthorized(description: String)
    case forbidden(description: String)
    case decodingError(description: String)
    case serverError(description: String)
    case error4xx(statusCode: Int, description: String)
    case urlSessionFailed(error: URLError, description: String)
    case unknownError(description: String)
    
    var errorDescription: String? {
        switch self {
        case .badRequest(let description):
            return description
        case .unauthorized(let description):
            return description
        case .forbidden(let description):
            return description
        case .error4xx(_, let description):
            return description
        case .serverError(let description):
            return description
        case .decodingError(let description):
            return description
        case .urlSessionFailed(_, let description):
            return description
        case .unknownError(let description):
            return description
        case .invalidRequest(description: let description):
            return description
        }
    }
}
