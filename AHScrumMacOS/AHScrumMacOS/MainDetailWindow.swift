//
//  AHScrumMainDetailWindow.swift
//  AHScrumMacOS
//
//  Created by Alvin HEIB on 12/05/2026.
//

import SwiftUI

struct MainDetailWindow: View {
    let item: NavigationItem
    
    var body: some View {
        Group {
            switch item {
            case .dashboard:
                Text("DashboardMainView") // The view with 3 boxes and 24/7 calendar
                    .font(.largeTitle)
            case .workspace:
                Text("WorkspaceMainView")
                    .font(.largeTitle)
            case .epic:
                Text("EpicMainView")
                    .font(.largeTitle)
            case .story:
                Text("StoryMainView")
                    .font(.largeTitle)
            case .task:
                Text("TaskMainView")
                    .font(.largeTitle)
            case .assistant:
                Text("AssitantMainView")
                    .font(.largeTitle)
            }
        }
        .navigationTitle(item.name)
        .toolbar {
            ToolbarItem {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
