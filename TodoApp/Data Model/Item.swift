//
//  Item.swift
//  TodoApp
//
//  Created by Ahmer Mughal on 24/01/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory =  LinkingObjects(fromType: Category.self, property: "items" )
}
