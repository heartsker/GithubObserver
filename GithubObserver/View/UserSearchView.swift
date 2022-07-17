//
//  UserSearchView.swift
//  GithubObserver
//
//  Created by Daniel Pustotin on 15.07.2022.
//

import SwiftUI

struct UserSearchView: View {

    @State var searchString: String = ""
    @State var loaded: Bool = true

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchString)

                    Button {
                        loaded = false
                        ApiModel.shared.usersList(pattern: searchString) { users in
                            Model.shared.users = users
                            print(searchString)
                            loaded = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                            Text("Search")
                        }
                    }
                }
                .padding()

                if loaded {
                    VStack {
                        if !searchString.isEmpty {
                            Text("Results for \(searchString):")
                        }
                        ScrollView {
                            Divider()
                                .padding(.horizontal)
                            ForEach(Model.shared.users) { user in
                                VStack {
                                    UserRowView(user: user)
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                } else {
                    Text("Loading...")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}
