//
//  CourseStore.swift
//  SwiftUI101
//
//  Created by phuongzzz on 5/2/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "i2yjjogi4t0j", accessToken: "HuquXH05rMMYou6xZrD-ur29Pi6DTMgEXck8kxxVxD8")

func getArray(contentTypeId: String, completion: @escaping (([Entry]) -> Void))  {
    let query = Query.where(contentTypeId: contentTypeId)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .error(let error):
            debugPrint(error.localizedDescription)
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = coursesData
    init() {
        getArray(contentTypeId: "course") { (items) in
            items.forEach { (item) in
                let myCourse = Course(
                    title: item.fields["title"] as! String,
                    subTitle: item.fields["subtitle"] as! String,
                    image: #imageLiteral(resourceName: "Card4"),
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
                    show: false)
                self.courses.append(myCourse)
            }
        }
    }
}





