//
//  ContentView.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.injected.managers) var managers: ManagersDIContainer
    @State private var peopleData: Loadable<[PeopleModel]> = .idle

    var body: some View {
        VStack {
            switch peopleData {
            case .idle:
                EmptyView()
            case .isLoading:
                ProgressView()
            case .loaded(let value):
                List {
                    ForEach(value, id: \.name) { entry in
                        Text(entry.name)
                    }
                }
            case .failed(let error):
                EmptyView()
            }
        }
        .onAppear {
            managers.peopleManager.getAllPeople($peopleData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
