//
//  FilmModel.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import Foundation

import Foundation

struct FilmModel: Identifiable {
    let id = UUID()
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    
    var crawlWordsNumber: Int {
        let components = openingCrawl.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.count
    }
}
