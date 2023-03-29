//
//  PeopleDTO.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

struct PeopleResponseDTO: Decodable {
    let count: Int
    let previous: String?
    let next: String?
    let results: [PeopleDTO]
}

struct PeopleDTO: Decodable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let films: [String]
}
