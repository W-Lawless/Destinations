//
//  GuideView.swift
//  Gestures
//
//  Created by W Lawless on 12/15/20.
//

import SwiftUI

struct GuideView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                Spacer(minLength: 10)
                Text("Get Started!")
                    .fontWeight(.black)
                    .modifier(TitleModifier())

                Text("Discover and pick the perfect place for your travel destination!")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                
                VStack(alignment: .leading, spacing: 25) {
                    GuideComponent(title: "Like", subtitle: "Swipe Right", description: "If you like this location, swipe right to save to favorites.", icon: "heart.circle")
                    GuideComponent(title: "Dismiss", subtitle: "Swipe Left", description: "If you would like to skip this, swipe left, and you will no longer see it in the stack.", icon: "xmark.circle")
                    GuideComponent(title: "Book", subtitle: "Button", description: "Book this location! Save this location and book it for later.", icon: "checkmark.square")
                }
                
                Spacer(minLength: 10)
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Continue".uppercased())
                        .modifier(ButtonMod())
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        } //: SCRL
    } //: BODY
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
