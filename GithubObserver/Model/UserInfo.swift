//
//  UserInfo.swift
//  GithubObserver
//
//  Created by Daniel Pustotin on 15.07.2022.
//

import Foundation

class UserInfo: Identifiable, Decodable {
    var login = String()
    var avatar_url = String()
    var name = String()
    var company = String()


    var blog = String()
    var location = String()

    var email = String()

    var bio = String()

    var public_repos = 0

    var following = 0
    var followers = 0

    var id = UUID()
}
