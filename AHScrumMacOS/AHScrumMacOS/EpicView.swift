//
//  EpicView.swift
//  AHScrumMacOS
//
//  Created by Alvin HEIB on 24/05/2026.
//

import SwiftUI

struct EpicView: View {
    var epic: Epic
    
    // Define a single row with a fixed height matching your StoryView
    let rows = [
        GridItem(.fixed(150))
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(epic.name)
                .font(.headline)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHGrid(rows: rows, spacing: 20) {
                    ForEach(epic.stories) { story in
                        StoryView(story: story)
                    }
                }
                // Add padding to prevent shadows and rotations from getting clipped
                .padding(.vertical, 20)
                .padding(.horizontal, 16)
            }
        }
        .background(.gray)
        .padding()
    }
}

#Preview {
    @Previewable @StateObject var db = Database.sample
    
    EpicView(epic: db.epics.first!)
        .environmentObject(db)
}
