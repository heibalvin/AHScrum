import SwiftUI
import Combine

enum StoryStatus: Int, Codable {
    case backlog, todo, ongoing, done
}

struct Story: Codable, Identifiable, Hashable, Equatable {
    var id: UUID = UUID()
    var index: Int // Tracks horizontal order inside its Epic
    var title: String
    var points: Int
    var status: StoryStatus
    var sprint: Sprint
}

struct Sprint: Codable, Identifiable, Hashable, Equatable {
    var id: UUID = UUID()
    var index: Int
    var name: String
    
    static var backlog: Sprint {
        // Using a fixed UUID or constant logic for backlog is safer,
        // but keeping your structure intact:
        return Sprint(index: -1, name: "Backlog")
    }
}

struct Epic: Codable, Identifiable, Hashable, Equatable {
    var id: UUID = UUID()
    var index: Int // Tracks vertical order on the board
    var name: String
    var stories: [Story]
}

class Database: ObservableObject {
    @Published var sprints: [Sprint]
    @Published var stories: [Story]
    @Published var epics: [Epic]
    
    init(sprints: [Sprint] = [], stories: [Story] = [], epics: [Epic] = []) {
        self.sprints = sprints
        self.stories = stories
        self.epics = epics
    }
    
    // Call this whenever you display data to ensure your UI mirrors the indices
    func sortDatabase() {
        // Sort epics vertically
        epics.sort { $0.index < $1.index }
            
        // Sort stories horizontally inside each epic
        for i in 0..<epics.count {
            epics[i].stories.sort { $0.index < $1.index }
        }
    }
        
    // MARK: - CRUD Reorder 1: Move Epic Position (Vertical)
    func moveEpic(from source: IndexSet, to destination: Int) {
        epics.move(fromOffsets: source, toOffset: destination)
            
        // Re-normalize vertical indices
        for i in 0..<epics.count {
            epics[i].index = i
        }
    }
        
    // MARK: - CRUD Reorder 2: Move Story Within the Same Epic (Horizontal)
    func moveStoryWithinEpic(epicID: UUID, from source: IndexSet, to destination: Int) {
        guard let epicIndex = epics.firstIndex(where: { $0.id == epicID }) else { return }
            
        epics[epicIndex].stories.move(fromOffsets: source, toOffset: destination)
            
        // Re-normalize horizontal indices for this specific epic
        for i in 0..<epics[epicIndex].stories.count {
            epics[epicIndex].stories[i].index = i
        }
    }
        
    // MARK: - CRUD Reorder 3: Move Story Between Different Epics
    func moveStory(storyID: UUID, fromSourceEpic sourceEpicID: UUID, toTargetEpic targetEpicID: UUID, targetNewIndex: Int) {
        guard let sourceEpicIndex = epics.firstIndex(where: { $0.id == sourceEpicID }),
            let targetEpicIndex = epics.firstIndex(where: { $0.id == targetEpicID }),
            let storyIndex = epics[sourceEpicIndex].stories.firstIndex(where: { $0.id == storyID }) else {
            return }
            
        // Remove from current parent
        var movingStory = epics[sourceEpicIndex].stories.remove(at: storyIndex)
            
        // Insert into new parent target location
        epics[targetEpicIndex].stories.insert(movingStory, at: targetNewIndex)
            
        // Normalize indices for both affected epics
        for i in 0..<epics[sourceEpicIndex].stories.count {
            epics[sourceEpicIndex].stories[i].index = i
        }
        for i in 0..<epics[targetEpicIndex].stories.count {
            epics[targetEpicIndex].stories[i].index = i
        }
    }
    
    static var sample: Database {
        // 1. Generate Sprints safely
        var sprints: [Sprint] = []
        for index in 0..<4 {
            sprints.append(Sprint(id: UUID(), index: index, name: "Sprint \(index)"))
        }
        
        let sprint0 = sprints[0]
        let sprint1 = sprints[1]
        let backlog = Sprint.backlog
        
        // 2. Define realistic Stories mapping to project management needs
        let authStories = [
            Story(id: UUID(), index: 0, title: "Implement Biometric Login (FaceID/TouchID)", points: 21, status: .done, sprint: sprint0),
            Story(id: UUID(), index: 1, title: "Design Password Reset Flow UI", points: 2, status: .ongoing, sprint: sprint1),
            Story(id: UUID(), index: 2, title: "Sign up via Google/Apple OAuth", points: 5, status: .todo, sprint: sprint1),
            Story(id: UUID(), index: 3, title: "Two-Factor Authentication (SMS/Email)", points: 8, status: .backlog, sprint: backlog)
        ]
        
        let checkoutStories = [
            Story(id: UUID(), index: 0, title: "Integrate Stripe Payment Gateway SDK", points: 8, status: .done, sprint: sprint0),
            Story(id: UUID(), index: 1, title: "Build Cart Summary View component", points: 3, status: .ongoing, sprint: sprint1),
            Story(id: UUID(), index: 2, title: "Apply Promo Code discount logic", points: 3, status: .todo, sprint: sprint1),
            Story(id: UUID(), index: 3, title: "Implement Apple Pay support", points: 5, status: .backlog, sprint: backlog)
        ]
        
        let searchStories = [
            Story(id: UUID(), index: 0, title: "Create Search Bar component with autocomplete", points: 5, status: .todo, sprint: sprint1),
            Story(id: UUID(), index: 1, title: "Filter products by price, rating, and brand", points: 5, status: .backlog, sprint: backlog)
        ]
        
        // Combine all stories for the flat array
        let allStories = authStories + checkoutStories + searchStories
        
        // 3. Group stories into Epics
        let epics = [
            Epic(id: UUID(), index: 0, name: "User Authentication & Onboarding", stories: authStories),
            Epic(id: UUID(), index: 1, name: "Seamless Checkout Experience", stories: checkoutStories),
            Epic(id: UUID(), index: 2, name: "Advanced Product Search & Discovery", stories: searchStories)
        ]
        
        return Database(sprints: sprints, stories: allStories, epics: epics)
    }
}
