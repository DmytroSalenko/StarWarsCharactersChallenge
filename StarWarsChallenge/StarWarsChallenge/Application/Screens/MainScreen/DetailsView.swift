//
//  DetailsView.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.injected.managers) var managers: ManagersDIContainer
    @State private var filmsRequestStatus: Loadable<[FilmModel]> = .idle
    var person: PeopleModel
    
    private enum Constants {
        static let descriptionTextSpacing: CGFloat = 10
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(person.name)
                .font(Font.title)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: Constants.descriptionTextSpacing) {
                Text("Height: \(person.height.capitalized)")
                Text("Mass: \(person.mass.capitalized)")
                Text("Hair color: \(person.hairColor.capitalized)")
                Text("Skin color: \(person.skinColor.capitalized)")
                Text("Eye color: \(person.eyeColor.capitalized)")
                
                Text("Appeared in:")
                    .font(Font.title2)
                    .padding(.top, 20)
            }
            .padding()
            
            
            VStack {
                switch filmsRequestStatus {
                case .idle:
                    EmptyView()
                case .isLoading:
                    ProgressView()
                case .loaded(let films):
                    VStack {
                        ForEach(films) { film in
                            HStack {
                                Text(film.title)
                                
                                Text("\(film.crawlWordsNumber) words")
                                    .padding(.horizontal)
                            }
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
            
            Spacer()
        }
        .fontWeight(.heavy)
        .foregroundColor(Color.yellow)
        .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
        .onAppear {
            managers.filmsManager.getFilms($filmsRequestStatus, ids: person.filmIds)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(person: PeopleModel(name: "Test",
                                        height: "150",
                                        mass: "150",
                                        hairColor: "test",
                                        skinColor: "test",
                                        eyeColor: "test",
                                        birthYear: "test",
                                        gender: "test",
                                        films: []))
    }
}
