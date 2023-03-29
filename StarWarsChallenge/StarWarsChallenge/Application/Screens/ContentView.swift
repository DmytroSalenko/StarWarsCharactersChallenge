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
                .sinkToLoadable({ loadableResult in
                    switch loadableResult {
                    case .loaded(let result):
                        print(result)
                    case .failed(let error):
                        print(error)
                    default:
                        print("unknown")
                    }
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
