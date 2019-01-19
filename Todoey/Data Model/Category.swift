//
//  Category.swift
//  Todoey
//
//  Created by MyMac on 2019-01-11.
//  Copyright © 2019 Apex. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    
    let items = List<Item>()
    
    
    
   // making array examples
//    let array = [1,2,3]
//    let array2 = [Int]()
//    let array3 : [Int] = [1,2,3]
//    let array4 : Array<Int> = [1,2,3]
//    let emptyArray = Array<Int>()
    
}
