//
//  PokemonView.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var pokemonListViewModel = PokemonListViewModel()
    @State private var searchText = ""
    @ObservedObject var networkMonitor = NetworkMonitor()
    
    @Environment(\.dismiss) var dismiss
    
    private var filteredPokemons: [Pokemon] {
        if searchText.isEmpty {
            return pokemonListViewModel.pokemons
        } else {
            return pokemonListViewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        
        if !networkMonitor.isConnected {
            VStack {
                Image(systemName: "wifi.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Text("Please check your Internet connection")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        } else {
            NavigationView {
                
                List {
                    ForEach(filteredPokemons) { pokemon in
                        NavigationLink {
                            PokemonDetailsView(viewModel: PokemonDetailsViewModel(pokemon: pokemon))
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("\(pokemon.name.capitalized)")
                                            .font(.title)
                                    }
                                    HStack {
                                        Text("\(pokemon.type.capitalized)")
                                            .italic()
                                        Circle()
                                            .foregroundColor(pokemon.typeColor)
                                            .frame(width: 14)
                                    }
                                }
                                Spacer()
                                PokemonImageView(imageURL: pokemon.imageURL,
                                                 isListView: true)
                            }
                        }
                    }
                    
                }
                .listStyle(.plain)
                .navigationTitle("Dragon Book")
                .searchable(text: $searchText)
                .refreshable {
                    await pokemonListViewModel.getPokemons()
                }
                .task {
                    await pokemonListViewModel.getPokemons()
                }
                .navigationBarItems(trailing:
                                        Button(action: {dismiss()} ,label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                    .contentShape(Circle())
                })
                                    
                                        .buttonStyle(PlainButtonStyle())
                                        .accessibilityLabel(Text("Close"))
                )
            }
            .navigationViewStyle(.stack)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
