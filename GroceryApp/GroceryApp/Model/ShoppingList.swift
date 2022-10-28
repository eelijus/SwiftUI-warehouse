//
//  ShoppingList.swift
//  GroceryApp
//
//  Created by Suji Lee on 2022/09/11.
//

import Foundation
import RealmSwift

class ShoppingList: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var address: String
    
    @Persisted var items: List<ShoppingItem> = List<ShoppingItem>()

    override class func primaryKey() -> String? {
        "id"
    }
}
