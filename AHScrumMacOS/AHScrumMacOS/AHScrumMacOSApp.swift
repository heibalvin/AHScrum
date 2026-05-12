//
//  AHScrumMacOSApp.swift
//  AHScrumMacOS
//
//  Created by Alvin HEIB on 12/05/2026.
//

import SwiftUI
import SwiftData

@main
struct AHScrumMacOSApp: App {
    var body: some Scene {
        WindowGroup {
            MainWindow()
                .frame(minWidth: 1200, minHeight: 800) // Minimum to prevent UI breaking
                .frame(idealWidth: 1440, idealHeight: 900) // The "Golden Size"
        }
        .windowStyle(.hiddenTitleBar) // Matches the clean look in your mockups
        .windowResizability(.contentSize)
    }
}
