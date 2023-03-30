//
//  FilmManager.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import Foundation

protocol FilmManagerProtocol: Unsubscriptable {
    func getFilms(_ requestStatus: LoadableSubject<[FilmModel]>, ids: [String])
}

final class FilmManager: FilmManagerProtocol {
    /* A real implementation of the FilmManagerProtocol.
     It contains all the logic related to the work with People data */
    let clients: APIClientsDIContainer
    var cancelBag = CancelBag()
    
    init(clients: APIClientsDIContainer) {
        self.clients = clients
    }
    
    deinit {
        cancelSubscriptions()
    }
    
    func getFilms(_ requestStatus: LoadableSubject<[FilmModel]>, ids: [String]) {
        requestStatus.wrappedValue.setIsLoading()
        
        ids.publisher
            .flatMap { id in
                self.clients.filmsAPIClient.getFilm(request: .getFilmRequest(id: id))
            }
            .collect()
            .map { $0 }
            .sinkToLoadable {
                requestStatus.wrappedValue = $0
            }
            .store(in: cancelBag)
        
    }
}

final class StubFilmManager: FilmManagerProtocol {
    var cancelBag = CancelBag()

    func getFilms(_ requestStatus: LoadableSubject<[FilmModel]>, ids: [String]) {
        
    }
}
