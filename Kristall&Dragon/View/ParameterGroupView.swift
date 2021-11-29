//
//  ParameterGroupView.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import SwiftUI

struct ParameterGroupView: View {
    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int

    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 170)
                .foregroundColor(.white.opacity(0.6))
                .cornerRadius(20)
                .padding()
            VStack {
                ParameterView(name: "Atk", color: .red, value: attack)
                ParameterView(name: "Def", color: .green, value: defense)
                ParameterView(name: "Hgt", color: .indigo, value: height)
                ParameterView(name: "Wgt", color: .cyan, value: weight)
            }
        }
    }
}

struct PokemonStatsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterGroupView(attack: 88, defense: 30, height: 20, weight: 4900)
    }
}
