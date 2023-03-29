//
//  PeopleManager.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

protocol PeopleManagerProtocol: Unsubscriptable {
  func getPeople(_ requestStatus: LoadableSubject<PeopleData>)
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
  
  func getPeople(_ requestStatus: LoadableSubject<PeopleData>) {
      requestStatus.wrappedValue.setIsLoading()
      clients.peopleAPIClient.getPeople(endpoint: .peopleEndpoint)
      .map {
        PeopleModelMapper.mapToModel(from: $0)
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
    func getPeople(_ requestStatus: LoadableSubject<PeopleData>) {
        
    }
}
