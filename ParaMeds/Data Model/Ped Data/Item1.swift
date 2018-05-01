//
//  File1.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Item1: Object {
    @objc dynamic var title1: String = ""
    @objc dynamic var done1: Bool = false
    let weight1 = List<Weight1>()
    var parentCategory = LinkingObjects(fromType: Category1.self, property: "items1")
}
