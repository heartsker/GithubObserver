//
//  Model.swift
//  GithubObserver
//
//  Created by Daniel Pustotin on 15.07.2022.
//

import SwiftUI

class Model: ObservableObject {

    static var shared: Model = Model()

    private init() {
        
    }

    @Published var users: [User] = []
}
