//
//  AddShoppingListItemScreen.swift
//  GroceryApp
//
//  Created by Suji Lee on 2022/09/11.
//

import SwiftUI
import RealmSwift

struct AddShoppingListItemScreen: View {
    
    @ObservedRealmObject var shoppingList: ShoppingList
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
         Text("sujileelea")
    }
}

struct AddShoppingListItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingListItemScreen(shoppingList: ShoppingList())
    }
}
