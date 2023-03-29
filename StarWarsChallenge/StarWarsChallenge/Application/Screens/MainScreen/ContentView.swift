//
//  ContentView.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.injected.managers) var managers: ManagersDIContainer
    @State private var peopleData: Loadable<PeopleData> = .idle

    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            managers.peopleManager.getPeople($peopleData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
