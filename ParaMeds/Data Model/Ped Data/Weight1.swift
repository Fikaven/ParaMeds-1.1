//
//  File2.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Weight1: Object {
    @objc dynamic var title2: String = ""
    @objc dynamic var done2: Bool = false
    var parentCategory = LinkingObjects(fromType: Item1.self, property: "weight1")
}

