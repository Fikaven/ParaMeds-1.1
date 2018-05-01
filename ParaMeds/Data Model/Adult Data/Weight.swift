//
//  File2.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Weight: Object {
    @objc dynamic var title3: String = ""
    @objc dynamic var done3: Bool = false
    var parentCategory = LinkingObjects(fromType: Item.self, property: "weight")
}

