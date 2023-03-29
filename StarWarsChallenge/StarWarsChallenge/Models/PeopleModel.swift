//
//  People.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

struct PeopleData {
    let count: Int
    let previous: String?
    let next: String?
    let results: [PeopleModel]
}

struct PeopleModel {
    let name: String
    let height: Int
    let mass: Int
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: Int
    let gender: String
    let films: [String]
}
