//
//  StarWarsChallengeApp.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import SwiftUI

@main
struct StarWarsChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .inject(AppEnvironment.bootstrap().container)
        }
    }
}
