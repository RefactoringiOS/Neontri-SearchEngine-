//
//  Starred.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation
import ObjectMapper
class Starred: Mappable {
    var id: Int = 0
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        id <- map["id"]
    }
}
