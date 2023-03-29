//
//  ContentView.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-29.
//

import SwiftUI

struct ContentView: View {
    var cancelBag = CancelBag()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            PeopleAPIClient().getPeople()
                .sink(receiveCompletion: {error in
                    print(error)
                }, receiveValue: {data in
                    print(data)
                })
                .store(in: cancelBag)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
