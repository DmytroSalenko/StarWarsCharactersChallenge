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
    static func peopleEndpoint(page: Int? = nil) -> Self {
        let path = "/api/people"
        var queryItems = [URLQueryItem]()
        if let page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        return APIEndpoint(path: path, queryItems: queryItems)
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
    
    func getPeople(endpoint: APIEndpoint=APIEndpoint.peopleEndpoint()) -> AnyPublisher<PeopleData, Error> {
        execute(endpoint.request, decodingType: PeopleResponseDTO.self)
            .map {
                PeopleModelMapper.mapToModel(from: $0)
            }
            .eraseToAnyPublisher()
    }
}

