//
//  iTourApp.swift
//  iTour
//
//  Created by Joshua Buhler on 11/18/23.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
