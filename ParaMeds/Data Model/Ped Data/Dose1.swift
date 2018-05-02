//
//  File2.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Dose1: Object {
    @objc dynamic var pedDose1: String = ""
    @objc dynamic var done2: Bool = false
    var parentCategory = LinkingObjects(fromType: Weight1.self, property: "weight1")
}
