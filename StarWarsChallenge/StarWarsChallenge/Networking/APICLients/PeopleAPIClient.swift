//
//  People.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation
import Combine

// MARK: - People endpoint
extension APIRequest {
    static func getPeopleRequest(page: Int? = nil) -> Self {
        let path = "/api/people"
        var queryItems = [URLQueryItem]()
        if let page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        return APIRequest(path: path, queryItems: queryItems)
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
    
    func getPeople(request: APIRequest) -> AnyPublisher<PeopleData, Error> {
        execute(request.request, decodingType: PeopleResponseDTO.self)
            .map {
                PeopleDataModelMapper.mapToModel(from: $0)
            }
            .eraseToAnyPublisher()
    }
}

