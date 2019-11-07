//
//  UserCellViewModel.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation

class UserCellViewModel: CellViewModel {
    var urlDetails: String?
    var avatarUrl: String?
    var login: String?
    var followers: Int?
    var publicRepos: Int?
    var fullName: String?
    var starreds: Int?
    var starredUrl: String?
    
    init(user:User) {
        super.init(item: user)
       
        self.urlDetails = user.urlDetails
        self.avatarUrl = user.avatarUrl
        self.login = user.login
        self.followers = user.followers
        self.publicRepos = user.publicRepos
        self.fullName = user.fullName
        self.starreds = 0
        self.starredUrl = ""
    }
}


