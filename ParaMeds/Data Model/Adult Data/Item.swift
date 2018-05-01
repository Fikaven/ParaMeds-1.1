//
//  File1.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    let weight = List<Weight>()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
