import SwiftUI

@main
struct JyotishSevaApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(.light) // Calm, readable for priests
        }
    }
}

// MARK: - Global App State
final class AppState: ObservableObject {
    @Published var useHindi: Bool = true
    @Published var recentKundalis: [Kundali] = []
    
    func addKundali(_ kundali: Kundali) {
        recentKundalis.insert(kundali, at: 0)
        if recentKundalis.count > 20 {
            recentKundalis = Array(recentKundalis.prefix(20))
        }
    }
}
