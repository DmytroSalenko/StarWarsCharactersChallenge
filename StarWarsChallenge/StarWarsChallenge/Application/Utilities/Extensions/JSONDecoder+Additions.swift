//
//  JSONDecoder+Additions.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

extension JSONDecoder {
  func withDecodingStrategy(_ strategy: KeyDecodingStrategy) -> Self {
    keyDecodingStrategy = strategy
    return self
  }
}
