//
//  HabitwsApp.swift
//  Habitws
//
//  Created by matheus vitor on 22/02/25.
//

import SwiftUI
import SwiftData

@main
struct HabitwsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [User.self, Habit.self])
    }
}
