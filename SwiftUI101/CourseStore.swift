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
        let colors: [UIColor] = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
        getArray(contentTypeId: "course") { (items) in
            items.forEach { (item) in
                let myCourse = Course(
                    title: item.fields["title"] as! String,
                    subTitle: item.fields["subtitle"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: Color(colors.randomElement()!),
                    show: false)
                self.courses.append(myCourse)
            }
        }
    }
}





