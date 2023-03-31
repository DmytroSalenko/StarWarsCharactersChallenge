//
//  StarWarsChallengeTests.swift
//  StarWarsChallengeTests
//
//  Created by Dima Salenko on 2023-03-29.
//

import XCTest
@testable import StarWarsChallenge

final class StarWarsChallengeTests: XCTestCase {   
    private var cancelBag = CancelBag()
    
    private var peopleAPIClientMock: PeopleAPIClient {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.protocolClasses = [MockResponseURLProtocol.self]
        return PeopleAPIClient(session: URLSession(configuration: sessionConfig))
    }
    
    private var filmsAPIClientMock: FilmsAPIClient {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.protocolClasses = [MockResponseURLProtocol.self]
        return FilmsAPIClient(session: URLSession(configuration: sessionConfig))
    }
    
    private func encodeToData<T>(_ obj: T) -> Data? where T: Encodable {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return try? encoder.encode(obj)
    }
    
    func testPeopleManagerReturnsCorrectResponseWhenFetchingPeople() throws {
        let getPeopleRequest = APIRequest.getPeopleRequest()
        guard let url = getPeopleRequest.request.url else {
            XCTFail("Invalid request URL")
            return
        }
        
        let mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: [:])
        let mockPeopleModel = PeopleDTO(name: "Test",
                                        height: "150",
                                        mass: "150",
                                        hairColor: "test",
                                        skinColor: "test",
                                        eyeColor: "test",
                                        birthYear: "test",
                                        gender: "test",
                                        films: [])
        let mockPeopleData = PeopleResponseDTO(count: 1, previous: nil, next: nil, results: [mockPeopleModel])
        
        guard let mockData = encodeToData(mockPeopleData) else {
            XCTFail("Invalid data encoding")
            return
        }
        
        MockResponseURLProtocol.registerResult(.success(mockData), for: url, response: mockResponse)
        
        let apiClient = peopleAPIClientMock
        
        apiClient.getPeople(request: getPeopleRequest)
            .sink(receiveCompletion: { _ in
                XCTFail("This API call is not supposed to return an error")
            }, receiveValue: { peopleData in
                XCTAssertEqual(peopleData, PeopleDataModelMapper.mapToModel(from: mockPeopleData))
            })
            .store(in: cancelBag)
    }
    
    func testFilmManagerReturnsCorrectResponseWhenFetchingFilm() throws {
        let getFilmRequest = APIRequest.getFilmRequest(id: "1")
        guard let url = getFilmRequest.request.url else {
            XCTFail("Invalid request URL")
            return
        }
        
        let mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: [:])
        let mockFilmModel = FilmDTO(title: "Test",
                                    episodeId: 1,
                                    openingCrawl: "Test",
                                    director: "Test",
                                    producer: "Test")
        
        guard let mockData = encodeToData(mockFilmModel) else {
            XCTFail("Invalid data encoding")
            return
        }
        
        MockResponseURLProtocol.registerResult(.success(mockData), for: url, response: mockResponse)
        
        let apiClient = filmsAPIClientMock
        
        apiClient.getFilm(request: getFilmRequest)
            .sink(receiveCompletion: { _ in
                XCTFail("This API call is not supposed to return an error")
            }, receiveValue: { filmModel in
                XCTAssertEqual(filmModel, FilmModelMapper.mapToModel(from: mockFilmModel))
            })
            .store(in: cancelBag)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
