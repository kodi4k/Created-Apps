//
//  Item.swift
//  ToDoL
//
//  Created by IVZ on 11.11.2022.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated = Date()
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
