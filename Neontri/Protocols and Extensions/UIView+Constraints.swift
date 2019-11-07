//
//  UIView+Constraints.swift
//  developer.github
//
//  Created by KOVIGROUP on 05/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation
import UIKit

// MARK - UIView + Constraints
extension UIView {
    
    @discardableResult func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func heightAnchor(equalTo height: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult func widthAnchor(equalTo height: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }
    
    @discardableResult func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }
}

