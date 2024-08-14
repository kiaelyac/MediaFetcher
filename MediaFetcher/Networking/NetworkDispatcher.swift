//
//  NetworkDispatcher.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Foundation
import Combine

/// `NetworkDispatcher` is responsible for executing network requests and handling the associated response and errors.
/// It uses `URLSession` to perform network operations and returns a `Publisher` that either emits the decoded data or an error.
struct NetworkDispatcher {
    
    let urlSession: URLSession!
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Executes a given `URLRequest` and returns a publisher with either the decoded data or a `NetworkRequestError`.
    ///
    /// - Parameter request: The `URLRequest` to be executed.
    /// - Returns: A publisher emitting either the decoded data (`ReturnType`) or a `NetworkRequestError`.
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { data, response in
                
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkRequestError.unknownError(description: "An unknown error occurred.")
                }
                if !(200...299).contains(response.statusCode) {

                    throw httpErrorHandling(response.statusCode)
                }
                return data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { error in
                return requestErrorHandling(error)
            }
            .eraseToAnyPublisher()
    }
    /// Maps HTTP status codes to `NetworkRequestError` types with descriptive messages.
    ///
    /// - Parameter statusCode: The HTTP status code from the response.
    /// - Returns: A `NetworkRequestError` corresponding to the status code.
    func httpErrorHandling(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400:
            return .badRequest(description: "Bad request. Please check your input and try again.")
        case 401:
            return .unauthorized(description: "Unauthorized. Please check your credentials.")
            case 403:
            return .forbidden(description: "Forbidden. You do not have permission to access this resource.")
        case 402, 405...499:
            return .error4xx(statusCode: statusCode, description: "Client error occurred. Status code: \(statusCode)")
        case 500:
            return .serverError(description: "Internal server error. Please try again later.")
        default:
            return .unknownError(description: "An unknown error occurred.")
        }
    }
    
    /// Maps errors from the `URLSession` publisher or decoding process to `NetworkRequestError` types with descriptive messages.
    ///
    /// - Parameter error: The error encountered during the network request or decoding.
    /// - Returns: A `NetworkRequestError` that provides more context about the failure.
    func requestErrorHandling(_ error: Error) -> NetworkRequestError {
        
        switch error {
        case is Swift.DecodingError:
            return .decodingError(description: "Failed to decode the response. Please contact support.")
        case let urlError as URLError:
            return .urlSessionFailed(error: urlError, description: "Network request failed. Error: \(urlError.localizedDescription)")
        case let error as NetworkRequestError:
            return error // Return the existing NetworkRequestError directly
        default:
            return .unknownError(description: "An unexpected error occurred. Error: \(error.localizedDescription)")
        }
    }
}


