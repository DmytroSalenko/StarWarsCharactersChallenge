//
//  People.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation
import Combine

// MARK: - People endpoint
extension APIEndpoint {
    static var peopleEndpoint: Self {
        let path = "/api/people"
        return APIEndpoint(path: path)
    }
}

// MARK: - People API client
final class PeopleAPIClient: APIClient {
  let session: URLSession
  
  init(session: URLSession) {
    self.session = session
  }
  
  convenience init() {
    self.init(session: URLSession(configuration: .default))
  }
  
    func getPeople(endpoint: APIEndpoint=APIEndpoint.peopleEndpoint) -> AnyPublisher<PeopleResponseDTO, Error> {
    execute(endpoint.request, decodingType: PeopleResponseDTO.self )
  }
}

