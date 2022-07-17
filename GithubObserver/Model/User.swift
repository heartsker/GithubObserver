//
//  User.swift
//  GithubObserver
//
//  Created by Daniel Pustotin on 15.07.2022.
//

import SwiftUI

class User: Identifiable, Decodable {
    var login = String()
    var html_url = String()
    var url = String()

    var id = UUID()
}
