//
//  NavigationItem.swift
//  AHScrumMacOS
//
//  Created by Alvin HEIB on 12/05/2026.
//

enum NavigationItem: Int, CaseIterable, Hashable {
    case dashboard = 0
    case workspace
    case epic
    case story
    case task
    case assistant

    // Computed Properties for the UI
    var name: String {
        let names = [
            "Dashboard",
            "Workspace",
            "Epic",
            "Story",
            "Task",
            "Assistant"
        ]
        return names[self.rawValue]
    }

    var icon: String {
        let icons = [
            "square.grid.2x2",
            "house",
            "flag",
            "doc.text.fill",
            "checkmark.square",
            "sparkles" // Alternative to person.and.sparkles
        ]
        return icons[self.rawValue]
    }
}
