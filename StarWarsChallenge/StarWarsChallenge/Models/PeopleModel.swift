//
//  People.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

struct PeopleResponse {
    let count: Int
    let previous: String?
    let next: String?
    let results: [PeopleModel]
}

struct PeopleModel {
    let name: String
    let height: Int
    let mass: Int
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let films: [String]
}
