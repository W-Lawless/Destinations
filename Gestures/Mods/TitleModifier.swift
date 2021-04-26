//
//  TitleModifier.swift
//  Gestures
//
//  Created by W Lawless on 12/28/20.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.pink)
    }
}


