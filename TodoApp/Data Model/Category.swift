//
//  Category.swift
//  TodoApp
//
//  Created by Ahmer Mughal on 24/01/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
