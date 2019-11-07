//
//  CellViewModel.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation

class CellViewModel {
    var id: Int?
    
    init(item: GitHubItem) {
        self.id = item.id
    }
}
