//
//  PeopleManager.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation
import Combine

protocol PeopleManagerProtocol: Unsubscriptable {
    func getAllPeople(_ requestStatus: LoadableSubject<[PeopleModel]>)
}

final class PeopleManager: PeopleManagerProtocol {
    /* A real implementation of the PeopleManagerProtocol.
     It contains all the logic related to the work with People data */
    let clients: APIClientsDIContainer
    var cancelBag = CancelBag()
    
    
    init(clients: APIClientsDIContainer) {
        self.clients = clients
    }
    
    deinit {
        cancelSubscriptions()
    }
    
    func getAllPeople(_ requestStatus: LoadableSubject<[PeopleModel]>) {
        requestStatus.wrappedValue.setIsLoading()
        
        // Get the total number of characters and calculate the total number of pages to request
        let pagesLeft = clients.peopleAPIClient.getPeople(request: .getPeopleRequest())
            .compactMap {
                let count = Double($0.count)
                let pagesLeft = ceil((count - 1) / 10)
                return Array(1...Int(pagesLeft))
            }.eraseToAnyPublisher()
        
        // Fetch all the characters from all the pages
        let data = pagesLeft.flatMap { ids in
            let models = ids.map({self.clients.peopleAPIClient.getPeople(request: .getPeopleRequest(page: Int($0)))})
            return Publishers.MergeMany(models)
                .collect()
                .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
        
        // Transform the response data into the flat sorted array of characters
        data.map { peopleData in
            peopleData.flatMap { $0.results }
                .sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
        .sinkToLoadable {
            requestStatus.wrappedValue = $0
        }
        .store(in: cancelBag)
    }
}

// MARK: - Stub implementation for PeopleManagerProtocol for testing
struct StubPeopleManager: PeopleManagerProtocol {
    var cancelBag = CancelBag()
    
    func getAllPeople(_ requestStatus: LoadableSubject<[PeopleModel]>) {
        
    }
}
