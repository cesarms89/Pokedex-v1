//
//  ContentView.swift
//  Pokedex
//
//  Created by Cesar Mendez Santos on 06/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = PokemonViewModel()
    @State private var pokemonToSearch = ""
    @State private var isDark: Bool = false
    
    private let numberOfColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: numberOfColumns) {
                    ForEach(viewModel.filteredPokemon, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonCellView(pokemon: pokemon, viewModel: viewModel)
                        }
                    }
                }
                .padding(20)
            }
            .searchable(text: $pokemonToSearch, prompt: "Search Pokemon")
            .onChange(of: pokemonToSearch, { oldValue, newValue in
                withAnimation {
                    viewModel.filteredPokemon(name: newValue)
                }
            })
            .navigationBarTitle("Pokedex", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("", systemImage: isDark ? "sun.min" : "moon"){
                        isDark.toggle()
                    }
                    .contentTransition(.symbolEffect(.replace))
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
