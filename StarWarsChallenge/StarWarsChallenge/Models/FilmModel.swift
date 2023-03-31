//
//  FilmModel.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import Foundation

import Foundation

struct FilmModel: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var episodeId: Int
    var openingCrawl: String
    var director: String
    var producer: String
    
    var crawlWordsNumber: Int {
        let components = openingCrawl.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.count
    }
}
