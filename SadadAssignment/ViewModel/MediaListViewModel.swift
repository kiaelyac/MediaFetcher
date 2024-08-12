//
//  MediaListViewModel.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import Foundation
import Combine

class MediaListViewModel: ObservableObject {
    
    @Published var mediaList: MediaList = []
    var cancelabele: Set<AnyCancellable> = []
    
    func getMediaList() {
        
        APIClient.dispatch(APIRouter.getMediaList())
            .sink { _ in
                
            } receiveValue: { [weak self] mediaList in
                self?.mediaList = mediaList
            }.store(in: &cancelabele)
    }
}
