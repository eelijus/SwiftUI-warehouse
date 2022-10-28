//
//  SwiftUIRealmApp.swift
//  SwiftUIRealm
//
//  Created by Suji Lee on 2022/09/13.
//

import SwiftUI
import RealmSwift

@main
struct SwiftUIRealmApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, Realm.Configuration())
        }
    }
}
