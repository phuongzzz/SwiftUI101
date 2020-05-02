//
//  CourseStore.swift
//  SwiftUI101
//
//  Created by phuongzzz on 5/2/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import Foundation
import Contentful

let client = Client(spaceId: "i2yjjogi4t0j", accessToken: "HuquXH05rMMYou6xZrD-ur29Pi6DTMgEXck8kxxVxD8")

func getArray()  {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        print(result)
    }
}
