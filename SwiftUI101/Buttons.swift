//
//  Buttons.swift
//  SwiftUI101
//
//  Created by phuongzzz on 5/5/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.6346924901, green: 0.8357445598, blue: 1, alpha: 1))
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.6346924901, green: 0.8357445598, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .blur(radius: 4)
                        .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(Color(#colorLiteral(red: 0.6346924901, green: 0.8357445598, blue: 1, alpha: 1)))
                        .padding(1)
                        .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 20, y: 20)
                .shadow(color: Color.white.opacity(0.5), radius: 20, x: -20, y: -20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.6346924901, green: 0.8357445598, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
