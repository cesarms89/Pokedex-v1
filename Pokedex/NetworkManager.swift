//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Cesar Mendez Santos on 06/06/24.
//

import Foundation

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    init () {}
    
    func getListOfPokemon(completed: @escaping (Result<[PokemonModel], APError>) -> Void ) {
        
        guard let url = URL(string: NetworkManager.baseURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data?.parseData(removeString: "null,") else {
                completed(.failure(.invalidURL))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([PokemonModel].self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
            
        }
        
        task.resume()
        
    }
}

extension Data {
    func parseData(removeString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}

struct MockData {
    static let pokemon = PokemonModel(
        id: 138,
        attack: 40,
        defense: 100,
        description: "Although long extinct, in rare cases, it can be genetically resurrected from fossils.",
        name: "omanyte",
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F67769B01-3C3E-4A70-8FDA-8148C9A372A5?alt=media&token=55e72207-1586-4c7e-9239-0249993ee715", 
        type: "water"
    )
}
