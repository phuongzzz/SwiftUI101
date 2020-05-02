//
//  CourseList.swift
//  SwiftUI101
//
//  Created by PhuongTHN on 5/1/20.
//  Copyright © 2020 phuongzzz. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(Double(self.activeView.height/500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    ForEach(store.courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseView(
                                show: self.$store.courses[index].show,
                                active: self.$active,
                                course: self.store.courses[index],
                                index: index, activeIndex:
                                self.$activeIndex, activeView:
                                self.$activeView)
                                .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.store.courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.store.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    var course: Course
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen boo")
                Text("About this course")
                    .font(.title).bold()
                Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sde Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60,
                   maxHeight: show ? .infinity : 280)
                .offset(y: show ? 460 : 0)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .opacity(show ? 1 : 0)
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subTitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .opacity(show ? 1: 0)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60,
                   maxHeight: show ? 460 : 280)
                .background(course.color)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: course.color.opacity(0.3), radius: 20, x: 0, y: 20)
                .gesture(
                    show ?
                        DragGesture().onChanged { value in
                            guard value.translation.height < 300 else { return }
                            guard value.translation.height > 0 else { return }
                            self.activeView = value.translation
                        }
                        .onEnded { value in
                            if self.activeView.height > 50 {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
                            self.activeView = .zero
                        } : nil
            )
                .onTapGesture {
                    self.show.toggle()
                    self.active.toggle()
                    if self.show {
                        self.activeIndex = self.index
                    } else {
                        self.activeIndex = -1 // nothing
                    }
            }
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10, z: 0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ?
                DragGesture().onChanged { value in
                    guard value.translation.height < 300 else { return }
                    guard value.translation.height > 0 else { return }
                    self.activeView = value.translation
                }
                .onEnded { value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                    }
                    self.activeView = .zero
                } : nil
        )
            .edgesIgnoringSafeArea(.all)
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subTitle: String
    var image: URL
    var logo: UIImage
    var color: Color
    var show: Bool
}

let coursesData: [Course] = [
    Course(title: "SwiftUI", subTitle: "Learn basic of swiftUI", image: URL(string: "https://dl.dropbox.com/s/8mh2u2243u7wo8u/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), show: false),
    Course(title: "SwiftUI Advanced", subTitle: "Learn advance of swiftUI", image: URL(string: "https://dl.dropbox.com/s/uto8mdrpopvkxup/Card6%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "fingerprint-2"), color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), show: false),
    Course(title: "UI Design for Developer", subTitle: "Learn basic of design", image: URL(string: "https://dl.dropbox.com/s/9mg9x3hcfkwoymv/Card5%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo3"), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)), show: false)
]
