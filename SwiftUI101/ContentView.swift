//
//  ContentView.swift
//  SwiftUI101
//
//  Created by phuongzzz on 4/13/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState: CGSize = .zero
    @State var showCard = false
    @State var bottomState: CGSize = .zero
    @State var fullState = false
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.2)
            )
            
            BackCardView()
                .frame(width: showCard ? 280 : 320, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeIn(duration: 0.35))
            
            BackCardView()
                .frame(width: 320, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeIn(duration: 0.25))
            
            CardView()
                .frame(width: showCard ? 375 : 320.0, height: 220.0)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.viewState = value.translation
                        self.show = true
                }
                .onEnded { value in
                    self.viewState = .zero
                    self.show = false
                }
            )
            
            VStack {
                Text("\(bottomState.height)")
                Spacer()
            }
       
            BottomCardView(show: $showCard)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
            .gesture(
                DragGesture().onChanged { value in
                    self.bottomState = value.translation
                    if self.fullState {
                        self.bottomState.height += -300
                    }
                    if self.bottomState.height < -300 {
                        self.bottomState.height = -300
                    }
                }
                .onEnded { value in
                    if self.bottomState.height > 50 {
                        self.showCard = false
                    }
                    
                    if (self.bottomState.height < -100 && !self.fullState) || (self.bottomState.height < -250 && self.fullState) {
                        self.bottomState.height = -300
                        self.fullState = true
                    }
                    else {
                        self.bottomState = .zero
                        self.fullState = false
                    }
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 2)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificates indicates that phuongzzz will be success if he keep working just like today")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20.0) {
                RingView(color1: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)), color2: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), size: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut.delay(0.3))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("SwiftUI Course").fontWeight(.bold)
                    Text("12 of 12 sections\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
        .padding(.horizontal, 16)
        .background(BlurView(style: .systemUltraThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
