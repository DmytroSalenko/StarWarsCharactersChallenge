//
//  PeopleModelMapper.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

struct PeopleModelMapper {
    static func mapToModel(from dto: PeopleResponseDTO) -> PeopleData {
        let peopleModels = dto.results.map {
            PeopleModel(name: $0.name,
                        height: Int($0.height) ?? 0,
                        mass: Int($0.mass) ?? 0,
                        hairColor: $0.hairColor,
                        skinColor: $0.skinColor,
                        eyeColor: $0.eyeColor,
                        birthYear: Int($0.birthYear) ?? 0,
                        gender: $0.gender,
                        films: $0.films)
        }
        
        return PeopleData(count: dto.count, previous: dto.previous, next: dto.next, results: peopleModels)
    }
}
