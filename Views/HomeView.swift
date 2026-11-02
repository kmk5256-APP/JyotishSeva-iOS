import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text(appState.useHindi ? "\u{091c}\u{092f} \u{0936}\u{094d}\u{0930}\u{0940} \u{0915}\u{0943}\u{0937}\u{094d}\u{0923}" : "Jai Shri Krishna")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.orange)
                        
                        Text(appState.useHindi ? "\u{091c}\u{094d}\u{092f}\u{094b}\u{0924}\u{093f}\u{0937} \u{0938}\u{0947}\u{0935}\u{093e}" : "Jyotish Seva")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(appState.useHindi ? "\u{092a}\u{0902}\u{0921}\u{093f}\u{0924}\u{094b}\u{0902} \u{0915}\u{0947} \u{0932}\u{093f}\u{090f} \u{0938}\u{092e}\u{0930}\u{094d}\u{092a}\u{093f}\u{0924} \u{090f}\u{092a}" : "Dedicated app for Pandits")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        NavigationLink {
                            NewKundaliView()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "\u{0928}\u{0908} \u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{0940}" : "New Kundali", icon: "star.circle.fill", color: .orange)
                        }
                        
                        NavigationLink {
                            MatchingView()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "\u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{0940} \u{092e}\u{093f}\u{0932}\u{093e}\u{0928}" : "Matching", icon: "heart.circle.fill", color: .pink)
                        }
                        
                        NavigationLink {
                            PanchangView()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "\u{0906}\u{091c} \u{0915}\u{093e} \u{092a}\u{0902}\u{091a}\u{093e}\u{0902}\u{0917}" : "Today's Panchang", icon: "calendar", color: .blue)
                        }
                        
                        Button {
                            appState.useHindi.toggle()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "English" : "\u{0939}\u{093f}\u{0902}\u{0926}\u{0940}", icon: "globe", color: .green)
                        }
                    }
                    .padding(.horizontal)
                    
                    if !appState.recentKundalis.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(appState.useHindi ? "\u{0939}\u{093e}\u{0932} \u{0915}\u{0940} \u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{093f}\u{092f}\u{093e}\u{0901}" : "Recent Kundalis")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(appState.recentKundalis.prefix(5)) { kundali in
                                NavigationLink {
                                    KundaliDetailView(kundali: kundali)
                                } label: {
                                    RecentKundaliRow(kundali: kundali, useHindi: appState.useHindi)
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    Text("\u{0950}")
                        .font(.system(size: 48))
                        .foregroundColor(.orange.opacity(0.3))
                }
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct RecentKundaliRow: View {
    let kundali: Kundali
    let useHindi: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(kundali.birthDetails.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(kundali.lagna) \u{2022} \(kundali.nakshatra)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
