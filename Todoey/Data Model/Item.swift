//
//  Item.swift
//  Todoey
//
//  Created by MyMac on 2019-01-11.
//  Copyright © 2019 Apex. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var timeIn : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}


