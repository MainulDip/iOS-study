//
//  Category.swift
//  TodoCoreData
//
//  Created by Mainul Dip on 8/31/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    var items = List<Item>()
}
