//
//  LoginView.swift
//  SwiftUI101
//
//  Created by phuongzzz on 5/14/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).edgesIgnoringSafeArea(.all)
            Color("background2")
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
                
            VStack {
                GeometryReader { geometry in
                    Text("Learn Design & Code. From Scratch.")
                        .font(.system(size: geometry.size.width/10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 375, maxHeight: 100)
                .padding(.horizontal, 16)
                
                Text("80 hours of courses for swift ui, react and designing tools")
                    .font(.subheadline)
                    .frame(width: 250)
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(Image(uiImage: #imageLiteral(resourceName: "Card5")), alignment: .bottom)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -200)
                        .blendMode(.plusDarker)
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -200, y: -250)
                        .blendMode(.overlay)
                }
            )
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        .previewDevice("iPhone Xs Max")
    }
}
