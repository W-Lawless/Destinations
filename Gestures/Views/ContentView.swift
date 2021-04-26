//
//  ContentView.swift
//  Gestures
//
//  Created by W Lawless on 12/13/20.
//

import SwiftUI

struct ContentView: View {
    //MARK:- PROPERTIES
    
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @GestureState private var dragState = DragState.inactive
    var dragAreaThreshHold = 65.0
    @State private var lastCardIndex: Int = 1
    @State private var cardRmTransition = AnyTransition.trailingBottom
    
    //MARK: - CARD VIEWS
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        return views
    }()
    
    //MARK: MOVE CARDS
    
    private func moveCard() {
        cardViews.removeFirst()
        
        self.lastCardIndex += 1
        
        let honeymoon = honeymoonData[lastCardIndex % honeymoonData.count]
        
        let newCardView = CardView(honeymoon: honeymoon)
        
        cardViews.append(newCardView)
    }
    
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    
    //MARK: - DRAG STATES
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
                case .pressing, .dragging:
                    return true
            case .inactive:
                return false
            }
        }
    }
    
    //MARK: - BODY
    
    var body: some View {
        VStack {
            //MARK: - HEADER
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
            
            Spacer()
            
            //MARK: - CARDS
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                //X-MARK
                                Image(systemName: "x.circle")
                                    .modifier(IconMod())
                                    .opacity(self.dragState.translation.width < -65.0 && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                
                                //HEART ICON
                                Image(systemName: "heart.circle")
                                    .modifier(IconMod())
                                 .opacity(self.dragState.translation.width > 65.0 && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                            }
                        )
                        .offset(x: self.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.85 : 1.0 )
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double(self.dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                        .transition(self.cardRmTransition)
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                        .sequenced(before: DragGesture())
                        .updating(self.$dragState, body: { (value, state, transaction) in
                            switch value {
                            case .first(true):
                                state = .pressing
                            case .second(true, let drag):
                                state = .dragging(translation: drag?.translation ?? .zero)
                            default:
                                break
                            }
                        })
                                    .onChanged({ value in
                                        guard case .second(true, let drag?) = value else {
                                            return
                                        }
                                        if drag.translation.width < -65.0 {
                                            self.cardRmTransition = .leadingBottom
                                        }
                                        if drag.translation.width > 65.0 {
                                            self.cardRmTransition = .trailingBottom
                                        }
                                    })
                        .onEnded({ value in
                            guard case .second(true, let drag?) = value else {
                                return
                            }
                            if drag.translation.width < -65.0 || drag.translation.width > 65.0 {
                                playSound(sound: "sound-rise", type: ".mp3")
                                self.moveCard()
                            }
                        })
                    )
                }
            }
            .padding(.horizontal)
            
            
            //MARK: - FOOTER
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
            
            Spacer()
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text("Success"),
                  message: Text("This location was succesfully booked!"),
                  dismissButton: .default(Text("Bon Voyage!")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
