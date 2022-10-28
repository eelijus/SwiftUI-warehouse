//
//  OneWeekAppApp.swift
//  OneWeekApp
//
//  Created by Suji Lee on 2022/09/28.
//

import SwiftUI

@main
struct OneWeekAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(calendar: Calendar(identifier: .gregorian))
        }
    }
}
