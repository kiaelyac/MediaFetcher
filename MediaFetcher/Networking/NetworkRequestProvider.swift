//
//  NetworkRequestProvider.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Foundation

// Enumeration for HTTP methods used in network requests.
enum HTTPMethod: String {
    case get = "Get"
    case post = "Post"
    case put = "Put"
    case delete = "Delete"
}

// Protocol for providing and constructing network requests
protocol NetworkRequestProvider {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}

// Defaults and Helper Methods
extension NetworkRequestProvider {
    //defaults
    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var queryParams: [String: Any]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
    
    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(parameters: [String: Any]?) -> Data? {
        guard let parameters = parameters else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return nil
        }
        return httpBody
    }
    
    /// Converts a conforming `NetworkRequestProvider` into a standard `URLRequest`.
    /// This method assembles the URL request by combining the base URL with the path, query parameters, headers, and body.
    ///
    /// - Parameter baseURL: The base URL to use for constructing the full request URL.
    /// - Returns: A `URLRequest` instance configured with the provided details, or `nil` if the request could not be created.
    func createURLRequest(baseURL: String) -> URLRequest? {
        // Ensure the base URL is valid and create URLComponents from it
        guard var urlComponent = URLComponents(string: baseURL) else { return nil }
        
        // Append the path to the base URL
        urlComponent.path = "\(urlComponent.path)\(path)"
        
        guard let finalURL = urlComponent.url else { return nil}
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = requestBodyFrom(parameters: parameters)
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}
