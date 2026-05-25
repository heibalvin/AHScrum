import SwiftUI

// Define our navigation targets
enum NavigationModule: String, CaseIterable, Identifiable {
    case design = "Design"
    case plan = "Plan"
    case execute = "Execute"
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .design: return "square.and.pencil"
        case .plan: return "calendar.badge.clock"
        case .execute: return "square.grid.3x2.fill"
        }
    }
}

struct ContentView: View {
    // 1. Snatch the central published database source of truth
    @EnvironmentObject var db: Database
    
    // Tracks what the user has tapped in the sidebar menu
    @State private var selectedModule: NavigationModule? = .design
    
    var body: some View {
        NavigationSplitView {
            // LEFT MENU SIDEBAR
            List(NavigationModule.allCases, selection: $selectedModule) { module in
                NavigationLink(value: module) {
                    Label(module.rawValue, systemImage: module.iconName)
                        .font(.headline)
                        .padding(.vertical, 4)
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Agile Hub")
            
        } detail: {
            // DETAIL CONTAINER PANELS
            if let module = selectedModule {
                switch module {
                case .design:
                    DesignBoardView()
                case .plan:
                    Text("PlanningBoardView")
                case .execute:
                    Text("ExecutionBoardView")
                }
            } else {
                Text("Select an operation hub from the menu.")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Database.sample)
}
