//
//  UpdateDetail.swift
//  SwiftUI101
//
//  Created by phuongzzz on 4/18/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update = updateData[0]
    
    var body: some View {
        List {
            VStack(spacing: 20.0) {
                update.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(update.title)
        }
        .listStyle(PlainListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
