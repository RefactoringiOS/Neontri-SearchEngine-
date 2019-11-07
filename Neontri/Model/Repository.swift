//
//  Repository.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: GitHubItem {
    var name: String?
    var fullName: String?
    var description: String?
    var language: String?
    var forksСount: Int?
    var watchersСount: Int?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        fullName <- map["full_name"]
        description <- map["description"]
        language <- map["language"]
        forksСount <- map["forks_count"]
        watchersСount <- map["watchers_count"]
    }
}
