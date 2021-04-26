//
//  ButtonMod.swift
//  Gestures
//
//  Created by W Lawless on 12/28/20.
//

import SwiftUI

struct ButtonMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(Color.pink)
            )
            .foregroundColor(Color.white)
    }
}

