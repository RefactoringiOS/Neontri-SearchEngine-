//
//  RepositoryCellViewModel.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation

class RepositoryCellViewModel: CellViewModel {
    var name: String?
    var fullName: String?
    var description: String?
    var language: String?
    var forksСount: Int = 0
    var watchersСount: Int = 0
    
    init(repository: Repository) {
        super.init(item: repository)
        
        self.name = repository.name
        self.fullName = repository.fullName
        self.description = repository.description
        self.language = repository.language
        self.forksСount = repository.forksСount!
        self.watchersСount = repository.watchersСount!
    }
}

