//
//  UserPortfolioViewController.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import UIKit
import AlamofireImage

class UserPortfolioViewController: UIViewController {
    private let avatarImageView = UIImageView()
    private let loginLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let followersLabel = UILabel()
    private let followersCountLabel = UILabel()
    private let publicReposLabel = UILabel()
    private let publicReposCountLabel = UILabel()
    private let starredLabel = UILabel()
    private let starredCountLabel = UILabel()
    
    //Data Source
    var userCellViewModel: UserCellViewModel?
    var portfolioViewModel = PortfolioViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setUserData()
        portfolioViewModel.getUserDetails(userCellViewModel: userCellViewModel!) { [unowned self] (success, userCellViewModel) in
            if success {
                self.userCellViewModel = userCellViewModel
                self.setUserData()
                self.portfolioViewModel.getUserStars(userCellViewModel: userCellViewModel!, completion: { [unowned self] (success, numberStarts) in
                    if success {
                        self.userCellViewModel?.starreds = Int(numberStarts!)
                        self.starredCountLabel.text = String(describing: numberStarts!)
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private
extension UserPortfolioViewController  {
    fileprivate func setUI() {
        self.title = "Portfolio"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        loginLabel.font = UIFont.boldSystemFont(ofSize: 15)
        followersLabel.font = UIFont.systemFont(ofSize: 14)
        publicReposLabel.font = UIFont.systemFont(ofSize: 14)
        starredLabel.font = UIFont.systemFont(ofSize: 14)
        followersLabel.textColor = UIColor.CustomColors.darkBlue
        publicReposLabel.textColor = UIColor.CustomColors.darkBlue
        starredLabel.textColor = UIColor.CustomColors.darkBlue
        followersLabel.text = "Followers"
        publicReposLabel.text = "Repositories"
        starredLabel.text = "Stars"
        starredCountLabel.text = "0"
        followersCountLabel.font = UIFont.systemFont(ofSize: 14)
        publicReposCountLabel.font = UIFont.systemFont(ofSize: 14)
        starredCountLabel.font = UIFont.systemFont(ofSize: 14)
        
        view.addSubview(fullNameLabel)
        view.addSubview(loginLabel)
        view.addSubview(avatarImageView)
        view.addSubview(followersLabel)
        view.addSubview(publicReposLabel)
        view.addSubview(starredLabel)
        view.addSubview(followersCountLabel)
        view.addSubview(publicReposCountLabel)
        view.addSubview(starredCountLabel)
        
        avatarImageView
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: view.topAnchor, constant: 60)
            .heightAnchor(equalTo: 170)
            .widthAnchor(equalTo: 170)
       
        fullNameLabel
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: avatarImageView.bottomAnchor, constant: 20)
        
        loginLabel
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: fullNameLabel.bottomAnchor, constant: 10)
       
        followersCountLabel
            .centerXAnchor(equalTo: followersLabel.centerXAnchor)
            .topAnchor(equalTo: loginLabel.bottomAnchor, constant: 40)
        
        publicReposCountLabel
            .centerXAnchor(equalTo: publicReposLabel.centerXAnchor)
            .topAnchor(equalTo: loginLabel.bottomAnchor, constant: 40)
        
        starredCountLabel
            .centerXAnchor(equalTo: starredLabel.centerXAnchor)
            .topAnchor(equalTo: loginLabel.bottomAnchor, constant: 40)
        
        followersLabel
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 20)
            .topAnchor(equalTo: followersCountLabel.bottomAnchor, constant: 10)
        
        publicReposLabel
            .centerXAnchor(equalTo: view.centerXAnchor)
            .topAnchor(equalTo: publicReposCountLabel.bottomAnchor, constant: 10)
       
        starredLabel
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -20)
            .topAnchor(equalTo: starredCountLabel.bottomAnchor, constant: 10)
    }
    
    fileprivate func setUserData() {
        fullNameLabel.text = userCellViewModel?.fullName ?? " "
        if let followers = userCellViewModel?.followers {
            followersCountLabel.text = String(describing: followers)
        } else {
            followersCountLabel.text = "0"
        }
        if let publicRepos = userCellViewModel?.publicRepos {
            publicReposCountLabel.text = String(describing: publicRepos)
        } else {
            publicReposCountLabel.text = "0"
        }
        loginLabel.text = userCellViewModel?.login
        avatarImageView.af_setImage(withURL: URL(string: (userCellViewModel?.avatarUrl)!)!, placeholderImage: UIImage(named: "placeholder"))
    }
}
