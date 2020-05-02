//
//  PostsList.swift
//  SwiftUI101
//
//  Created by phuongzzz on 5/2/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct PostsList: View {
    @State var posts: [Post] = []
    
    var body: some View {
        List(posts) { post in
            Text(post.title)
        }
        .onAppear {
            Api().getPosts { posts in
                self.posts = posts
            }
        }
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList()
    }
}
