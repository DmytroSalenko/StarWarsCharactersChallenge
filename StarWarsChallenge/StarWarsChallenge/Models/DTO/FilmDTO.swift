//
//  FilmDTO.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import Foundation

struct FilmDTO: Decodable {
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
}
