//
//  DesignBoardView.swift
//  AHScrumMacOS
//
//  Created by Alvin HEIB on 24/05/2026.
//

import SwiftUI

struct DesignBoardView: View {
    @EnvironmentObject var db: Database
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(db.epics) { epic in
                    EpicView(epic: epic)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var db = Database.sample
    
    DesignBoardView()
        .environmentObject(db)
}
