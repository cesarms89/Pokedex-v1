//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Cesar Mendez Santos on 08/06/24.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @State private var isAnimating = false
    
    let pokemon: PokemonModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(maxHeight: 250)
            .shadow(radius: 12)
            .scaleEffect(isAnimating ? 1.2 : 0.7)
            
            Text(pokemon.description)
                .font(.system(size: 28))
                .lineLimit(4)
                .padding(.top, 20)
            
            Divider()
            
            VStack {
                Text("Type: \(pokemon.type)")
                    .font(.title2)
                    .padding(10)
                HStack {
                    Text("Attack: \(pokemon.attack)")
                        .foregroundColor(.red)
                    Spacer()
                    Text("Defense: \(pokemon.attack)")
                        .foregroundColor(.green)
                }
                .padding(10)
            }
            .font(.title2)
            .bold()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
        .padding(15)
        .navigationTitle(pokemon.name)
    }
}

#Preview {
    PokemonDetailView(pokemon: MockData.pokemon)
}
