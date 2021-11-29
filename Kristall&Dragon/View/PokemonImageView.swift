//
//  PokemonImageView.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonImageView: View {
    let imageURL: String
    let isListView: Bool
    
    var body: some View {
        WebImage(url: URL(string: imageURL)!)
            .onSuccess { image, data, cacheType in
                
            }
            .resizable()
            .scaledToFill()
            .frame(width: isListView ? 50 : 100,
                   height: isListView ? 50 : 100)
            .modifier(StyleForImage(isListView: isListView))
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(imageURL: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334",
                         isListView: true)
    }
}
