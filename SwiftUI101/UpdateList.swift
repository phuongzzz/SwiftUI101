//
//  UpdateList.swift
//  SwiftUI101
//
//  Created by phuongzzz on 4/18/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    
    
    func addUpdate() {
        store.updates.append(Update(image: Image(uiImage: #imageLiteral(resourceName: "Background1")), title: "new item", text: "This is my new item", date: "Jan 2020"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { item in
                    NavigationLink(destination: UpdateDetail(update: item)) {
                        HStack {
                            item.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(item.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(item.text)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                Text(item.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add new item")
            }, trailing: EditButton())
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: Image
    var title: String
    var text: String
    var date: String
}

let updateData: [Update] = [
    Update(image: Image(uiImage: #imageLiteral(resourceName: "Card5")), title: "Learning SwiftUI", text: "Mastering swift ui as soon as possible", date: "18/4/2020"),
       Update(image: Image(uiImage: #imageLiteral(resourceName: "Background1")), title: "Learning Design", text: "Mastering Sketch ui as soon as possible", date: "18/6/2020")
]


