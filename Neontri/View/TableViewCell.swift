//
//  TableViewCell.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import UIKit
import AlamofireImage

class TableViewCell: UITableViewCell {
    private var loginLabel: UILabel = {
       let label = UILabel()
       return label
    }()
    private var avatarImageView: UIImageView = {
      let imageView = UIImageView()
      return imageView
    }()

        // MARK: - LifeCycle
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.setUI()
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:)")
        }
        
        func setUserData(user:UserCellViewModel) {
            loginLabel.text = user.login
            avatarImageView.af_setImage(withURL: URL(string: user.avatarUrl!)!, placeholderImage: UIImage(named: "placeholder"))
        }

        func setUI()  {
            loginLabel.font = UIFont.boldSystemFont(ofSize: 16)
            contentView.addSubview(loginLabel)
            contentView.addSubview(avatarImageView)
            avatarImageView
                .centerYAnchor(equalTo: contentView.centerYAnchor)
                .leadingAnchor(equalTo: contentView.leadingAnchor, constant: 10)
                .heightAnchor(equalTo: 40)
                .widthAnchor(equalTo: 40)
            loginLabel
                .centerYAnchor(equalTo: contentView.centerYAnchor)
                .leadingAnchor(equalTo: avatarImageView.trailingAnchor, constant: 10)
        }
    }
