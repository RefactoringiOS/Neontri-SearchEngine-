//
//  PortfolioViewModel.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation

class PortfolioViewModel: NSObject {
    fileprivate var httpClient:HttpClient = HttpClient()
    func getUserDetails(userCellViewModel: UserCellViewModel, completion: @escaping (Bool, UserCellViewModel?) -> ()) {
        httpClient.getUserDetails(userURL: (userCellViewModel.urlDetails)!, successCallback: { (currentUser) -> Void in
            userCellViewModel.fullName = currentUser.fullName
            userCellViewModel.followers = currentUser.followers
            userCellViewModel.publicRepos = currentUser.publicRepos
            userCellViewModel.starredUrl = (userCellViewModel.urlDetails)! + "/starred"
            completion(true, userCellViewModel)
        }) { (error) -> Void in
            completion(false, nil)
        }
    }
    
    func getUserStars(userCellViewModel: UserCellViewModel, completion: @escaping (Bool, Int?) -> ()) {
        self.httpClient.getUserStarts(starredURL: (userCellViewModel.starredUrl!), successCallback: { (numberStarts) -> Void in
            completion(true, numberStarts)
        }, errorCallback: { (error) -> Void in
            completion(false, nil)
        })
    }
}
