//
//  File.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Category1: Object {
    @objc dynamic var pedDrug1: String = ""
    let items1 = List<Weight1>()
}
