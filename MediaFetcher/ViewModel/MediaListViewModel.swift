//
//  MediaListViewModel.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Combine

class MediaListViewModel: ObservableObject {
    
    @Published var mediaList: MediaList = []
    @Published var isLoading = true
    @Published var receivedError = false
    @Published var errorMessage = ""
    var cancelable: Set<AnyCancellable> = []
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getMediaList() {
        self.isLoading = true
        apiClient.dispatch(APIRouter.GetMediaList())
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.errorDescription ?? "Unable to connect to the server"
                    self.receivedError = true
                    self.isLoading = false
                }
            } receiveValue: { [weak self] mediaList in
                self?.mediaList = mediaList
            }.store(in: &cancelable)
    }
}
