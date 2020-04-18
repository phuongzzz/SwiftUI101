//
//  UpdateStore.swift
//  SwiftUI101
//
//  Created by phuongzzz on 4/18/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject  {
    @Published var updates: [Update] = updateData
}
