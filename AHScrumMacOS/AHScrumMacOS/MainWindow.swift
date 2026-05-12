//
//  AHScrumMainWindow.swift
//  AHScrumMacOS
//
//  Created by Alvin HEIB on 12/05/2026.
//

import SwiftUI

struct MainWindow: View {
    @State private var selectedItem: NavigationItem? = .dashboard
    
    var body: some View {
        NavigationSplitView {
            // Sidebar Column
            List(NavigationItem.allCases, id: \.self, selection: $selectedItem) { item in
                NavigationLink(value: item) {
                    Label(item.name, systemImage: item.icon)
                        .font(.largeTitle)
                        .padding(.vertical, 4)
                }
            }
            .navigationTitle("AHScrum")
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(min: 240, ideal: 240, max: 240)
            
            // Bottom "Assistant" sticky placement (Optional variation)
            // If you want Assistant at the very bottom, you can use a VStack with a Spacer.
        } detail: {
            // Detail Column
            if let selectedItem = selectedItem {
                MainDetailWindow(item: selectedItem)
            } else {
                Text("Select an item from the sidebar")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(minWidth: 900, minHeight: 600) // Setting a default macOS window size
    }
}

