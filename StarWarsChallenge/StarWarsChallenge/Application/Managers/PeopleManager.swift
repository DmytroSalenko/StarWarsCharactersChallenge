//
//  PeopleManager.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

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
        
        var pages = [1, 2, 3, 4, 5, 6, 7, 8, 9].publisher
        
        pages.flatMap { page in
            self.clients.peopleAPIClient.getPeople(endpoint: .peopleEndpoint(page: page))
        }
        .collect()
        .map {
            $0.flatMap { $0.results }
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
