//
//  MediumWidget.swift
//  GitBrowser (iOS)
//
//  Created by Ravi Tripathi on 26/07/20.
//

import SwiftUI
import WidgetKit
import Kingfisher
import GitBrowser

struct MediumWidget: View {
    
    @State var user: User
    @State var imageData: Data
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: imageData)!)
                .resizable()
                .frame(width: 100.0, height: 100.0)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                Text(user.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                Text("@\(user.login ?? "")")
                    .font(.title2)
                Text("Followers: \(user.followers ?? 0)")
                Text("Followers: \(user.following ?? 0)")
                HStack {
                    Image(systemName: "location.fill")
                    Text("\(user.location ?? "Unknown")")
                }
            }
        }.padding()
    }
}

struct MediumWidget_Previews: PreviewProvider {
    
    static var dummyUser: User = {
        let user = User()
        user.name = "John Doe"
        user.login = "johndoe"
        user.company = "Company brrrr"
        user.avatar_url = "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true"
        return user
    }()
    
    static var previews: some View {
        Group {
            MediumWidget(user: MediumWidget_Previews.dummyUser, imageData: UIImage(systemName: "person")!.pngData()!)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
