//
//  URLProtocolMock.swift
//  StarWarsChallengeTests
//
//  Created by Dima Salenko on 2023-03-30.
//

import Foundation

class MockResponseURLProtocol: URLProtocol {
    static var mockResults: [URL: Result<Data, Error>] = [:]
    static var mockResponses: [URL: HTTPURLResponse] = [:]

    static func registerResult(_ result: Result<Data, Error>, for key: URL, response: HTTPURLResponse? = nil) {
        MockResponseURLProtocol.mockResults[key] = result

        if let response = response {
            MockResponseURLProtocol.mockResponses[key] = response
        } else {
            MockResponseURLProtocol.mockResponses.removeValue(forKey: key)
        }
    }

    override class func canInit(with request: URLRequest) -> Bool {
        guard let url = request.url else { return false }
        return mockResults.keys.contains(url)
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let url = request.url else { fatalError("Invalid URL") }
        guard let result = MockResponseURLProtocol.mockResults[url] else {
            fatalError(
                "No mock response for \(url)"
            )
        }

        switch result {
        case .success(let data):
            guard let defaultResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
                fatalError(
                    "Failed to produce a default response for \(url)"
                )
            }

            let response = MockResponseURLProtocol.mockResponses[url, default: defaultResponse]

            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        case .failure(let error):
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        // Protocolo requires this function to be overriden even if it does nothing
    }
}
