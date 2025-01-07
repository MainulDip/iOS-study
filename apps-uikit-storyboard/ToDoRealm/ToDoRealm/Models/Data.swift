//
//  Data.swift
//  ToDoRealm
//
//  Created by Mainul Dip on 9/1/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    // dynamic is a "declaration" keyword which makes it a dynamic dispatch instade of a static dispatch
    // allows the marked property beign monitord for change wihile on runtime (app running)
    // @objc denotes merkes it clear that this "dynamic" keyword is comming form the Ojective C API
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
