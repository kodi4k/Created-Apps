//
//  Category.swift
//  ToDoL
//
//  Created by IVZ on 11.11.2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
