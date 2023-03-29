//
//  CancelBag.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import Foundation
import Combine

final class CancelBag {
    var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}

// MARK: - Adds the default ability for the Interactor to cancel all the Publishers
protocol Unsubscriptable {
    var cancelBag: CancelBag { get }
    func cancelSubscriptions()
}

extension Unsubscriptable {
    func cancelSubscriptions() {
        cancelBag.cancel()
    }
}
