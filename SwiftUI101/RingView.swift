//
//  RingView.swift
//  SwiftUI101
//
//  Created by phuongzzz on 4/21/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct RingView: View {
    var color1: Color = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    var color2: Color = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    var size: CGFloat = 300
    var percent: CGFloat = 90
    
    var body: some View {
        let progress: CGFloat = 1 - (percent / 100)
        let multiple = size / 140
        
        return ZStack {
            Circle()
                .stroke(
                    Color.black.opacity(0.1),
                    style: StrokeStyle(lineWidth: 10 * multiple, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: progress, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 10 * multiple, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: size, height: size)
                .shadow(color: color2,
                        radius: 10 * multiple, x: 0, y: 3)
            Text("\(Int(percent))%")
                .font(.system(size: 30 * multiple))
                .fontWeight(.bold)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 1)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
