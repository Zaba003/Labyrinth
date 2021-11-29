//
//  StyleForImage.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import SwiftUI

struct StyleForImage: ViewModifier {
    let isListView: Bool

    func body(content: Content) -> some View {
        if !isListView {
            content
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 5))
                .shadow(radius: 5)
        } else { content }
    }
}
