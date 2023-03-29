//
//  APIClient.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation
import Combine

protocol APIClient {
  var session: URLSession { get }
  func execute(_ request: URLRequest, queue: DispatchQueue, retries: Int) -> AnyPublisher<Data, Error>
  func execute<T>(_ request: URLRequest, decodingType: T.Type, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

extension APIClient {
  func execute(_ request: URLRequest,
               queue: DispatchQueue = .main,
               retries: Int = 0) -> AnyPublisher<Data, Error> {
    return session.dataTaskPublisher(for: request)
      .tryMap {
        guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
          throw APIError.responseUnsuccessful
        }
        return $0.data
      }
      .receive(on: queue)
      .retry(retries)
      .eraseToAnyPublisher()
  }
  
  func execute<T>(_ request: URLRequest,
                  decodingType: T.Type,
                  queue: DispatchQueue = .main,
                  retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
    return session.dataTaskPublisher(for: request)
      .tryMap {
        guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
          throw APIError.responseUnsuccessful
        }
        return $0.data
      }
      .decode(type: T.self, decoder: JSONDecoder().withDecodingStrategy(.convertFromSnakeCase))
      .receive(on: queue)
      .retry(retries)
      .eraseToAnyPublisher()
  }
}
