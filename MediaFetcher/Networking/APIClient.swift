//
//  APIClient.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Combine

// Define a protocol for APIClient
protocol APIClientProtocol {
     func dispatch<R: NetworkRequestProvider>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
}

struct APIClient: APIClientProtocol {
    
    static var networkDispatcher: NetworkDispatcher = NetworkDispatcher()
    
    /// Dispatches a Request and returns a publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded data or an error
     func dispatch<R: NetworkRequestProvider>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        
        guard let urlRequest = request.createURLRequest(baseURL: ApiConstants.baseUrl) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest(description: "Bad request. Please check your input and try again.")).eraseToAnyPublisher()
        }
        
        typealias RequestPublisher = AnyPublisher<R.ReturnType, NetworkRequestError>
         let requestPublisher: RequestPublisher = APIClient.networkDispatcher.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}

