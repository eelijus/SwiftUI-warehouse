//
//  ContentView.swift
//  GroceryApp
//
//  Created by Suji Lee on 2022/09/11.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(ShoppingList.self) var shoppingLists
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if shoppingLists.isEmpty {
                    Text("No Shopping Lists!")
                }
                
                List {
                    ForEach(shoppingLists, id: \.id) { shoppingList in
                        NavigationLink {
                            ShoppingListItemScreen(shoppingList: shoppingList)
                        } label: {
                            VStack {
                                Text(shoppingList.title)
                                Text(shoppingList.address)
                                    .opacity(0.4)
                            }
                        }
                    }.onDelete(perform: $shoppingLists.remove)
                }
                
                
                    .navigationTitle("Grocery App")
            }
            .sheet(isPresented: $isPresented, content: {
                AddShoppingListScreen()
            })
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                isPresented = true
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                }
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
