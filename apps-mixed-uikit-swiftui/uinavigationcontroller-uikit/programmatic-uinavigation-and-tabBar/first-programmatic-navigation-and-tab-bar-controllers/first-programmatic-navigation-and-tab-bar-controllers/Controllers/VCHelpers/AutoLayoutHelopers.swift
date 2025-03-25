//
//  AutoLayoutHelopers.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//


import UIKit

func centerXYToParent(view: UIView, parentView: UIView) -> Void {
    view.translatesAutoresizingMaskIntoConstraints = false
    view.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
    view.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
}
