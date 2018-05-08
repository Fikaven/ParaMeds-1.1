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
    @objc dynamic var pInjct: String = ""
    @objc dynamic var pfrstDose: String = ""
    @objc dynamic var pScndDose: String = ""
    @objc dynamic var done2: Bool = false
    var parentCategory = LinkingObjects(fromType: Weight1.self, property: "weight1")
}
