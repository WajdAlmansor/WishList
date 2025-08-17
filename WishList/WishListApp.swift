//
//  WishListApp.swift
//  WishList
//
//  Created by Wajd on 17/08/2025.
//

import SwiftUI
import SwiftData

@main
struct WishListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            //#4
                .modelContainer(for: Wish.self)
        }
    }
}
