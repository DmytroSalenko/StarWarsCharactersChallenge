//
//  CompositionRoot.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

struct AppEnvironment {
    let container: ManagersDIContainer
}

extension AppEnvironment {
    /* The only purpose of this function is to configure our application.
     It instantiates all the managers and clients in order to inject them
     into the app environment */
    static func bootstrap() -> AppEnvironment {
        let urlSession = configuredURLSession()
        let apiClients = configuredAPIClients(urlSession: urlSession)
        let managers = configuredManagers(apiClients: apiClients)
        
        return AppEnvironment(container: managers)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        
        return URLSession(configuration: configuration)
    }
    
    private static func configuredAPIClients(urlSession: URLSession) -> APIClientsDIContainer {
        return APIClientsDIContainer(session: urlSession)
    }
    
    private static func configuredManagers(apiClients: APIClientsDIContainer) -> ManagersDIContainer {
        return ManagersDIContainer(apiClients: apiClients)
    }
}
