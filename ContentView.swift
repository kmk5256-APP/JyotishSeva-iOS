import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(appState.useHindi ? "\u092e\u0941\u0916\u094d\u092f" : "Home", systemImage: "house.fill")
                }
            
            NewKundaliView()
                .tabItem {
                    Label(appState.useHindi ? "\u0915\u0941\u0902\u0921\u0932\u0940" : "Kundali", systemImage: "star.circle.fill")
                }
            
            MatchingView()
                .tabItem {
                    Label(appState.useHindi ? "\u092e\u093f\u0932\u093e\u0928" : "Matching", systemImage: "heart.circle.fill")
                }
            
            PanchangView()
                .tabItem {
                    Label(appState.useHindi ? "\u092a\u0902\u091a\u093e\u0902\u0917" : "Panchang", systemImage: "calendar")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
