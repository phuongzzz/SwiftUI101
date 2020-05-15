//
//  LoginView.swift
//  SwiftUI101
//
//  Created by phuongzzz on 5/14/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).edgesIgnoringSafeArea(.all)
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
                
            CoverView()
            
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.2099903822, green: 0.3703026474, blue: 0.4322733581, alpha: 1)))
                        .frame(width: 44, height: 44)
                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                        .padding(.leading)
                    TextField("Your email goes here", text: $email)
                        .keyboardType(.emailAddress)
                        .font(.subheadline)
                        .padding(.leading)
                        .frame(height: 44)
                }
                Divider().padding(.leading, 80)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.2099903822, green: 0.3703026474, blue: 0.4322733581, alpha: 1)))
                        .frame(width: 44, height: 44)
                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                        .padding(.leading)
                    SecureField("Your password goes here", text: $password)
                        .keyboardType(.default)
                        .font(.subheadline)
                        .padding(.leading)
                        .frame(height: 44)
                }
            }
            .frame(height: 136)
            .frame(maxWidth: .infinity)
            .background(BlurView(style: .systemThinMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
            .padding(.horizontal)
            .offset(y: 460)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        .previewDevice("iPhone Xs Max")
    }
}

struct CoverView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn Design & Code. From Scratch.")
                    .font(.system(size: geometry.size.width/10, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            .offset(x: viewState.width/10, y: viewState.height/10)
            
            Text("80 hours of courses for swift ui, react and designing tools")
                .font(.subheadline)
                .frame(width: 250)
                .offset(x: viewState.width/15, y: viewState.height/15)
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360 + 90 : 90))
//                    .animation( Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .animation(nil)
                    .blendMode(.plusDarker)
                    .onAppear {
                        self.show = true
                }
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
//                    .animation( Animation.linear(duration: 60).repeatForever(autoreverses: false))
                    .animation(nil)
                    .blendMode(.overlay)
                    .onAppear {
                        self.show = true
                }
            }
        )
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card5"))
                    .offset(x: viewState.width/25, y: viewState.height/25),
                alignment: .bottom)
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isDragging ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))

            .gesture(
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                    self.isDragging = true
                }.onEnded { value in
                    self.viewState = CGSize.zero
                    self.isDragging = false
                }
        )
    }
}
