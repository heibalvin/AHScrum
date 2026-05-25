import SwiftUI

@main
struct MyApp: App {
    @StateObject var db = Database.sample
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 1024, minHeight: 768)
                .environmentObject(db)
        }
    }
}
