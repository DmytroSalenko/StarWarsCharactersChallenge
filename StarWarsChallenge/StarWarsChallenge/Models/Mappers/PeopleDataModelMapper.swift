//
//  PeopleModelMapper.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

struct PeopleDataModelMapper {
    static func mapToModel(from dto: PeopleResponseDTO) -> PeopleData {
        let peopleModels = dto.results.map {
            PeopleModelMapper.mapToModel(from: $0)
        }
        
        return PeopleData(count: dto.count, previous: dto.previous, next: dto.next, results: peopleModels)
    }
}

struct PeopleModelMapper {
    static func mapToModel(from dto: PeopleDTO) -> PeopleModel {
        PeopleModel(name: dto.name,
                    height: dto.height,
                    mass: dto.mass,
                    hairColor: dto.hairColor,
                    skinColor: dto.skinColor,
                    eyeColor: dto.eyeColor,
                    birthYear: dto.birthYear,
                    gender: dto.gender,
                    films: dto.films)
    }
}
