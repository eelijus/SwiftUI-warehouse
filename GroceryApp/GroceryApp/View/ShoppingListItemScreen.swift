//
//  ShoppingListItemScreen.swift
//  GroceryApp
//
//  Created by Suji Lee on 2022/09/11.
//

import SwiftUI
import RealmSwift

struct ShoppingListItemScreen: View {
    
    @ObservedRealmObject var shoppingList: ShoppingList
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Items")
    
                .navigationTitle("HEB")
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            }.sheet(isPresented: $isPresented) {
                AddShoppingListItemScreen(shoppingList: shoppingList)
            }
        
    }
}

struct ShoppingListItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShoppingListItemScreen(shoppingList: ShoppingList())
        }
    }
}
