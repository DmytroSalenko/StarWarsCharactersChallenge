//
//  DependencyInjection.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation
import SwiftUI

struct APIClientsDIContainer {
    let peopleAPIClient: PeopleAPIClient
    
    init(session: URLSession = URLSession(configuration: .default)) {
        peopleAPIClient = PeopleAPIClient(session: session)
    }
}

struct ManagersDIContainer {
    let peopleManager: PeopleManagerProtocol

    static var stub: Self {
        ManagersDIContainer(peopleManager: StubPeopleManager())
    }
}

extension ManagersDIContainer {
    init(apiClients: APIClientsDIContainer) {
        peopleManager = PeopleManager(clients: apiClients)
    }
}

// MARK: - Dependency Injection Container to store all the managers of the app
final class DIContainer: EnvironmentKey {
  typealias Value = DIContainer
    static var defaultValue = DIContainer(managers: .stub)
  
  let managers: ManagersDIContainer
  
  init(managers: ManagersDIContainer) {
    self.managers = managers
  }
}

extension EnvironmentValues {
  var injected: DIContainer {
    get {
      self[DIContainer.self]
    }
    
    set {
      self[DIContainer.self] = newValue
    }
  }
}

// MARK: - Injection in the view hierarchy
extension View {
  func inject(_ managers: ManagersDIContainer) -> some View {
    let container = DIContainer(managers: managers)
    return inject(container)
  }
  
  func inject(_ container: DIContainer) -> some View {
    return self
      .environment(\.injected, container)
  }
}
