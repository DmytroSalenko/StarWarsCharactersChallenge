//
//  Loadable.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation

enum Loadable<Value> {
    case idle
    case isLoading
    case loaded(Value)
    case failed(Error)
    
    var value: Value? {
        switch self {
        case let .loaded(value): return value
        default: return nil
        }
    }
    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
}

extension Loadable {
    mutating func setIsLoading() {
        self = .isLoading
    }
    
    func map<V>(_ transform: (Value) throws -> V) -> Loadable<V> {
        do {
            switch self {
            case .idle:
                return .idle
            case let .failed(error):
                return .failed(error)
            case .isLoading:
                return .isLoading
            case let .loaded(value):
                return .loaded(try transform(value))
            }
        } catch {
            return .failed(error)
        }
    }
}

// MARK: - Loadable + Optinal unwrap for getting the value from the optional results
protocol SomeOptional {
    associatedtype Wrapped
    func unwrap() throws -> Wrapped
}

struct ValueIsMissingError: Error {
    var localizedDescription: String {
        NSLocalizedString("Data is missing", comment: "")
    }
}

extension Optional: SomeOptional {
    func unwrap() throws -> Wrapped {
        switch self {
        case let .some(value): return value
        case .none: throw ValueIsMissingError()
        }
    }
}

extension Loadable where Value: SomeOptional {
    func unwrap() -> Loadable<Value.Wrapped> {
        map { try $0.unwrap() }
    }
}

// MARK: - Loadable + Equatable for comparing the results
extension Loadable: Equatable where Value: Equatable {
    static func == (lhs: Loadable<Value>, rhs: Loadable<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.isLoading, .isLoading): return true
        case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
        case let (.failed(lhsE), .failed(rhsE)):
            return lhsE.localizedDescription == rhsE.localizedDescription
        default: return false
        }
    }
}
