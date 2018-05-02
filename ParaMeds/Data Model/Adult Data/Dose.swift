//
//  File2.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Dose: Object {
    @objc dynamic var adltDose: String = ""
    @objc dynamic var done3: Bool = false
    var parentCategory = LinkingObjects(fromType: Weight.self, property: "wght1")
}
