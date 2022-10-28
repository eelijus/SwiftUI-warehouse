//
//  ShoppingItem.swift
//  GroceryApp
//
//  Created by Suji Lee on 2022/09/11.
//

import Foundation
import RealmSwift

class ShoppingItem: Object, Identifiable {
     
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var quantity: Int
       
    override class func primaryKey() -> String? {
        return "id"
    }
}
