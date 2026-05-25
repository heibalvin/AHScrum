//
//  StoryView.swift
//  AHScrumMacOS
//
//  Created by Alvin HEIB on 24/05/2026.
//

import SwiftUI

struct StoryView: View {
    var story: Story
    
    // 1. Store the random angle in state
    @State private var rotationAngle: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(story.title)
                .font(.headline)
            Spacer()
            Text("Points: \(story.points)")
                .font(.subheadline)
        }
        .padding()
        .frame(width: 150, height: 150)
        // 2. Post-it yellow background
        .background(Color(red: 0.99, green: 0.93, blue: 0.47))
        // 3. Subtle realistic bottom shadow
        .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 4)
        // 4. Apply the dynamic angle
        .rotationEffect(.degrees(rotationAngle))
        // 5. Generate the random angle once the view loads
        .onAppear {
            rotationAngle = Double.random(in: -4...4)
        }
    }
}

#Preview {
    StoryView(story: Database.sample.stories.first!)
}
