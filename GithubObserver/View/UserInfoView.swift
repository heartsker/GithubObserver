//
//  UserInfoView.swift
//  GithubObserver
//
//  Created by Daniel Pustotin on 15.07.2022.
//

import SwiftUI

struct UserInfoView: View {
    @State var user: User
    @State var userInfo: UserInfo = UserInfo()
    @State var isLoaded = false

    var profile: some View {
        VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: userInfo.avatar_url))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300, alignment: .leading)
                    .clipShape(Circle())
                    .offset(x: -100)

            HStack {
                Text(userInfo.login)
                    .font(.title2)

                Text(userInfo.name)
                    .font(.title3)
            }

            HStack {
                HStack {
                    Image(systemName: "person.2.crop.square.stack.fill")
                    Text("Bio:")
                        .font(.title3)
                }
                Text(userInfo.bio)
                    .font(.title3)
            }


            HStack {
                Image(systemName: "house.fill")
                Text("Company: \(userInfo.company)")
                    .font(.title3)
            }

            HStack {
                Image(systemName: "at.circle.fill")
                Text("Email: \(userInfo.email)")
                    .font(.title3)
            }

            HStack {
                Image(systemName: "mappin.circle.fill")
                Text("Location: \(userInfo.location)")
                    .font(.title3)
            }

            HStack {
                Image(systemName: "person.2.fill")
                VStack {
                    Text("Followers: \(userInfo.followers)")
                        .font(.title3)

                    Text("Following: \(userInfo.following)")
                        .font(.title3)
                }
            }

            if !userInfo.blog.isEmpty {
                HStack {
                    Link(destination: URL(string: userInfo.blog)!) {
                        HStack {
                            Image(systemName: "scribble.variable")
                            Text("Blog")
                        }
                    }
                }
                .font(.title3)
            }

            Spacer()
        }
//        .offset(y: 100)
    }

    var body: some View {
        VStack(alignment: .leading) {
            if !isLoaded {
                Text("Loading...")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                profile
            }
        }
        .navigationTitle(Text(user.login))
        .onAppear {
            ApiModel.shared.userInfo(login: user.login) { info in
                userInfo = info
                isLoaded = true
            }
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(user: User())
    }
}
