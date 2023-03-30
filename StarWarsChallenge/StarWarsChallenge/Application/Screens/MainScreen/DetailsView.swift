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
        VStack {
            Text(person.name)
                .font(Font.title)
                .padding(.bottom)
            
            HStack {
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
                
                Spacer()
            }
            
            VStack {
                switch filmsRequestStatus {
                case .idle:
                    EmptyView()
                case .isLoading:
                    ProgressView()
                case .loaded(let films):
                    VStack {
                        ForEach(films) { film in
                            Text(film.title)
                        }
                    }
                case .failed(_):
                    EmptyView()
                }
            }
            
            Spacer()
        }
        .onAppear {
            managers.filmsManager.getFilms($filmsRequestStatus, ids: ["1", "2"])
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
