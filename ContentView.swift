import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(appState.useHindi ? "\u{092e}\u{0941}\u{0916}\u{094d}\u{092f}" : "Home", systemImage: "house.fill")
                }
            
            NewKundaliView()
                .tabItem {
                    Label(appState.useHindi ? "\u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{0940}" : "Kundali", systemImage: "star.circle.fill")
                }
            
            MatchingView()
                .tabItem {
                    Label(appState.useHindi ? "\u{092e}\u{093f}\u{0932}\u{093e}\u{0928}" : "Matching", systemImage: "heart.circle.fill")
                }
            
            PanchangView()
                .tabItem {
                    Label(appState.useHindi ? "\u{092a}\u{0902}\u{091a}\u{093e}\u{0902}\u{0917}" : "Panchang", systemImage: "calendar")
                }
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
