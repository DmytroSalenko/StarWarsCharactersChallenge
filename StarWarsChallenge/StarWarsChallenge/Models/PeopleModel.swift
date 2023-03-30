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

struct PeopleModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let films: [String]
    
    var filmIds: [String] {
        films.compactMap { URL(string: $0)?.lastPathComponent }
    }
}
