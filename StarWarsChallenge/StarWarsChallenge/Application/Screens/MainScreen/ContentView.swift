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
            case .loaded(let peopleModels):
                NavigationStack {
                    List(peopleModels) { person in
                        NavigationLink(person.name, value: person)
                    }
                    .navigationDestination(for: PeopleModel.self) { person in
                            DetailsView(person: person)
                        }
                }
            case .failed(_):
                VStack {
                    Spacer()
                    Text("Oops. Something wrong happened. Try again you must")
                    Spacer()
                }
            }
        }
        .foregroundColor(Color.blue)
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
