//
//  UserRowView.swift
//  GithubObserver
//
//  Created by Daniel Pustotin on 15.07.2022.
//

import SwiftUI

struct UserRowView: View {

    @State var user: User

    var body: some View {
        HStack {

            VStack {
                Text(user.login)
                    .font(.title)

                Link("View on GitHub", destination: URL(string: user.url)!)
            }

            NavigationLink {
                UserInfoView(user: user)
            } label: {
                Text("More info")
            }

        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User())
    }
}
