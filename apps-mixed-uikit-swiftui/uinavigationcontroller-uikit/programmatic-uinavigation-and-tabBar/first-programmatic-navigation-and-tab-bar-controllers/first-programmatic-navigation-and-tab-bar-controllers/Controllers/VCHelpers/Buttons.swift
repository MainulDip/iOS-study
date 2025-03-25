//
//  Buttons.swift
//  first-programmatic-navigation-and-tab-bar-controllers
//
//  Created by Mainul Dip on 3/24/25.
//

import UIKit

func navButton(target: Any?, title: String, actionHandler: Selector) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.addTarget(target, action: actionHandler, for: .touchUpInside)
    return button
}
