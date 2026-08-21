import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text(appState.useHindi ? "\u091c\u092f \u0936\u094d\u0930\u0940 \u0915\u0943\u0937\u094d\u0923" : "Jai Shri Krishna")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.orange)
                        
                        Text(appState.useHindi ? "\u091c\u094d\u092f\u094b\u0924\u093f\u0937 \u0938\u0947\u0935\u093e" : "Jyotish Seva")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(appState.useHindi ? "\u092a\u0902\u0921\u093f\u0924\u094b\u0902 \u0915\u0947 \u0932\u093f\u090f \u0938\u092e\u0930\u094d\u092a\u093f\u0924 \u090f\u092a" : "Dedicated app for Pandits")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        NavigationLink {
                            NewKundaliView()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "\u0928\u0908 \u0915\u0941\u0902\u0921\u0932\u0940" : "New Kundali", icon: "star.circle.fill", color: .orange)
                        }
                        
                        NavigationLink {
                            MatchingView()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "\u0915\u0941\u0902\u0921\u0932\u0940 \u092e\u093f\u0932\u093e\u0928" : "Matching", icon: "heart.circle.fill", color: .pink)
                        }
                        
                        NavigationLink {
                            PanchangView()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "\u0906\u091c \u0915\u093e \u092a\u0902\u091a\u093e\u0902\u0917" : "Today's Panchang", icon: "calendar", color: .blue)
                        }
                        
                        Button {
                            appState.useHindi.toggle()
                        } label: {
                            QuickActionCard(title: appState.useHindi ? "English" : "\u0939\u093f\u0902\u0926\u0940", icon: "globe", color: .green)
                        }
                    }
                    .padding(.horizontal)
                    
                    if !appState.recentKundalis.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(appState.useHindi ? "\u0939\u093e\u0932 \u0915\u0940 \u0915\u0941\u0902\u0921\u0932\u093f\u092f\u093e\u0901" : "Recent Kundalis")
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
                    
                    Text("\u0950")
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
                Text("\(kundali.lagna) \u2022 \(kundali.nakshatra)")
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
