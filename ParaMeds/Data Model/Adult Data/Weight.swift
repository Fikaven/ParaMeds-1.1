//
//  File1.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Weight: Object {
    @objc dynamic var aweight: String = ""
    @objc dynamic var done: Bool = false
    let wght1 = List<Dose>()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
