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
}
