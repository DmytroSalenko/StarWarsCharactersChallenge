//
//  DetailsView.swift
//  StarWarsChallenge
//
//  Created by Dima Salenko on 2023-03-30.
//

import SwiftUI

struct DetailsView: View {
    var person: PeopleModel
    
    private enum Constants {
        static let descriptionTextSpacing: CGFloat = 10
    }
    
    var body: some View {
        VStack() {
            Text(person.name)
                .font(Font.title)
                .padding(.bottom)
            
            HStack {
                VStack(alignment: .leading, spacing: Constants.descriptionTextSpacing) {
                    Text("Height: \(person.height)")
                    Text("Mass: \(person.mass)")
                    Text("Hair color: \(person.hairColor)")
                    Text("Skin color: \(person.skinColor)")
                    Text("Eye color: \(person.eyeColor)")
                }
                .padding()
                
                Spacer()
            }
            
            
            Text("Appeared in:")
                .font(Font.title2)
            
            VStack {
                
            }
            
            Spacer()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(person: PeopleModel(name: "Test",
                                        height: 100,
                                        mass: 150,
                                        hairColor: "test",
                                        skinColor: "test",
                                        eyeColor: "test",
                                        birthYear: "test",
                                        gender: "test",
                                        films: []))
    }
}
