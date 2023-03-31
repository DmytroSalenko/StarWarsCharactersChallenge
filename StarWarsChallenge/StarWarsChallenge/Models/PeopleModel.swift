//
//  People.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

struct PeopleData: Codable, Equatable {
    var count: Int
    var previous: String?
    var next: String?
    var results: [PeopleModel]
}

struct PeopleModel: Identifiable, Hashable, Codable, Equatable {
    var id = UUID()
    var name: String
    var height: String
    var mass: String
    var hairColor: String
    var skinColor: String
    var eyeColor: String
    var birthYear: String
    var gender: String
    var films: [String]
    
    var filmIds: [String] {
        films.compactMap { URL(string: $0)?.lastPathComponent }
    }
}
