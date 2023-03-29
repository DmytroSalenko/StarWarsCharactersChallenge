//
//  APIEndpoint.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
}

struct APIEndpoint {
    var baseURL: String = "swapi.dev/api/"
    var path: String
    var method: APIMethod = APIMethod.get
    var scheme: String = "https"
    var queryItems: [URLQueryItem] = []
    var headers: [String: String]?
    var body: Data?
    
    var baseURL: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        return components.url!
    }
    
    var pathWithQueryItems: URL {
        var components = URLComponents()
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        return components.url!
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        return components
    }
    
    var request: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { key, value in request.setValue(value, forHTTPHeaderField: key) }
        return request
    }
}
