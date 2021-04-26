//
//  GuideComponent.swift
//  Gestures
//
//  Created by W Lawless on 12/15/20.
//

import SwiftUI

struct GuideComponent: View {
    //MARK:- PROPERTIES
    
    var title: String
    var subtitle: String
    var description: String
    var icon: String
    
    
    //MARK: - BODY
    var body: some View {
        //HSTQ A
        HStack(alignment: .center, spacing: 20) {
            
            //IMG
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(Color.pink)
            
            //VSTQ A
            VStack(alignment: .leading, spacing: 4){
                //HSTQ B
                HStack {
                    Text(title.uppercased())
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Text(subtitle.uppercased())
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.pink)
                } //: HSTQ B
                Divider().padding(.bottom, 4)
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            } //: VSTQ A
        } //: HSTQ A
        
     
        
    } //: BODY
}

struct GuideComponent_Previews: PreviewProvider {
    static var previews: some View {
        GuideComponent(title: "Title", subtitle: "Swipe Right", description: "Placholder sentence this is. Placholder sentence this is. Placholder sentence this is.", icon: "heart.circle")
            .previewLayout(.sizeThatFits)
    }
}
