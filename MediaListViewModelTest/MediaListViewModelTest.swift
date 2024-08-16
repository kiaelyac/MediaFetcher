//
//  MediaListViewModelTest.swift
//  MediaListViewModelTest
//
//  Created by kiarash on 8/16/24.
//

import Combine
import XCTest

final class MediaListViewModelTest: XCTestCase {
    
    var viewModel: MediaListViewModel!
    var mockAPIClient: MockAPIClient!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        viewModel = MediaListViewModel(apiClient: mockAPIClient)
    }
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    func testSuccessfulMediaListRetrieval() {
        // Setup mock data
        let expectedMediaList: MediaList = MediaList.mockData
        
        // Use an expectation to wait for the asynchronous operation
        let expectation = self.expectation(description: "Media list should be retrieved successfully")
        
        // Subscribe to changes in the view model's mediaList
        viewModel.$mediaList
            .dropFirst() // To skip the initial value
            .sink { mediaList in
                XCTAssertEqual(mediaList, expectedMediaList)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Trigger the API call in the view model
        viewModel.getMediaList()
        
        // Simulate successful data retrieval
        mockAPIClient.mediaListPublisher.send(expectedMediaList)
        mockAPIClient.mediaListPublisher.send(completion: .finished)
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1.0, handler: nil)
        
        // Perform additional assertions
        XCTAssertFalse(viewModel.receivedError)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertFalse(viewModel.isLoading)
    }
    func testFailedMediaListRetrieval() {
        // Setup the expected error
        let expectedError = NetworkRequestError.decodingError(description: "")
        
        // Use an expectation to wait for the asynchronous operation
        let expectation = self.expectation(description: "Media list retrieval should fail")
        
        // Subscribe to changes in the view model's errorMessage
        viewModel.$errorMessage
            .dropFirst() // To skip the initial value
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, expectedError.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Trigger the API call in the view model
        viewModel.getMediaList()
        
        // Simulate a failed data retrieval
        mockAPIClient.mediaListPublisher.send(completion: .failure(expectedError))
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1.0, handler: nil)
        
        // Perform additional assertions
        XCTAssertTrue(viewModel.receivedError)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.mediaList.isEmpty)  // mediaList should be empty on failure
    }
    func testSuccessfulEmptyMediaListRetrieval() {
        let expectedMediaList: MediaList = []
        // Use an expectation to wait for the asynchronous operation
        let expectation = self.expectation(description: "Media list should be retrieved successfully(empty)")
        // Subscribe to changes in the view model's mediaList
        viewModel.$mediaList
            .dropFirst() // To skip the initial value
            .sink { mediaList in
                XCTAssertEqual(mediaList, expectedMediaList)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Trigger the API call in the view model
        viewModel.getMediaList()
        
        // Simulate successful data retrieval
        mockAPIClient.mediaListPublisher.send(expectedMediaList)
        mockAPIClient.mediaListPublisher.send(completion: .finished)
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1.0, handler: nil)
        
        // Perform additional assertions
        XCTAssertFalse(viewModel.receivedError)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertFalse(viewModel.isLoading)
    }
}
