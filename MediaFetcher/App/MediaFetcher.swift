//
//  SadadAssignmentApp.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import SwiftUI

@main
struct MediaFetcher: App {
    @StateObject var coordinator = NavigationCoordinator()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.navigationPath) {
                coordinator.build(page: .mediaList)
                    .navigationDestination(for: Page.self) { page in
                        coordinator.build(page: page)
                            
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
