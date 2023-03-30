//
//  FilmModelMapper.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import Foundation

struct FilmModelMapper {
    static func mapToModel(from dto: FilmDTO) -> FilmModel {
        FilmModel(title: dto.title,
                  episodeId: dto.episodeId,
                  openingCrawl: dto.openingCrawl,
                  director: dto.director,
                  producer: dto.producer)
    }
}
