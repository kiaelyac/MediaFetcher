//
//  MockAPIClient.swift
//  MediaFetcher
//
//  Created by kiarash on 8/15/24.
//

import Combine

class MockAPIClient: APIClientProtocol {
    var mediaListPublisher: PassthroughSubject<MediaList, NetworkRequestError> = PassthroughSubject()
     func dispatch<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : NetworkRequestProvider {
        if request is APIRouter.GetMediaList {
            // Cast the publisher to the expected type
            return mediaListPublisher
                .map { $0 as! R.ReturnType }
                .eraseToAnyPublisher()
        }
        // Return an empty publisher or handle other requests
        return Empty<R.ReturnType, NetworkRequestError>()
            .eraseToAnyPublisher()
    }
}
