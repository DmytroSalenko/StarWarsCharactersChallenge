//
//  FilmsAPIClient.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import Foundation
import Combine

// MARK: - Films endpoint
extension APIRequest {
    static func getFilmRequest(id: String) -> Self {
        let path = "/api/films"
        return APIRequest(path: path, appendingPathWith: [id])
    }
}

// MARK: - Films API client
final class FilmsAPIClient: APIClient {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    convenience init() {
        self.init(session: URLSession(configuration: .default))
    }
    
    func getFilm(request: APIRequest) -> AnyPublisher<FilmModel, Error> {
        execute(request.request, decodingType: FilmDTO.self)
            .map {
                FilmModelMapper.mapToModel(from: $0)
            }
            .eraseToAnyPublisher()
    }
}
