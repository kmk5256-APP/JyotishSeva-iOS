import SwiftUI

struct KundaliDetailView: View {
    let kundali: Kundali
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text(kundali.birthDetails.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(kundali.birthDetails.formattedDate) \u2022 \(kundali.birthDetails.formattedTime)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(kundali.birthDetails.placeName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(16)
                .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    InfoCard(title: appState.useHindi ? "\u0932\u0917\u094d\u0928" : "Lagna", value: kundali.lagna)
                    InfoCard(title: appState.useHindi ? "\u0930\u093e\u0936\u093f" : "Moon Sign", value: kundali.moonSign)
                    InfoCard(title: appState.useHindi ? "\u0928\u0915\u094d\u0937\u0924\u094d\u0930" : "Nakshatra", value: kundali.nakshatra)
                    InfoCard(title: appState.useHindi ? "\u0928\u0915\u094d\u0937\u0924\u094d\u0930 \u0938\u094d\u0935\u093e\u092e\u0940" : "Nakshatra Lord", value: kundali.nakshatraLord)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(appState.useHindi ? "\u0935\u0930\u094d\u0924\u092e\u093e\u0928 \u0926\u0936\u093e" : "Current Dasha")
                        .font(.headline)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(kundali.currentDasha)
                                .fontWeight(.semibold)
                            Text(kundali.currentAntardasha)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "clock.fill")
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(appState.useHindi ? "\u0917\u094d\u0930\u0939 \u0938\u094d\u0925\u093f\u0924\u093f" : "Planetary Positions")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(kundali.planets) { position in
                        PlanetRow(position: position, useHindi: appState.useHindi)
                    }
                }
                
                Text(appState.useHindi
                     ? "\u26a0\ufe0f \u092f\u0939 \u0921\u0947\u092e\u094b \u0921\u0947\u091f\u093e \u0939\u0948\u0964 \u0935\u093e\u0938\u094d\u0924\u0935\u093f\u0915 \u0917\u0923\u0928\u093e \u0915\u0947 \u0932\u093f\u090f Swiss Ephemeris \u091c\u094b\u0921\u093c\u0947\u0902\u0964"
                     : "\u26a0\ufe0f Demo data only. Integrate Swiss Ephemeris for production accuracy.")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(appState.useHindi ? "\u0915\u0941\u0902\u0921\u0932\u0940" : "Kundali")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct PlanetRow: View {
    let position: PlanetPosition
    let useHindi: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Text(position.planet.symbol)
                .font(.title2)
                .frame(width: 36)
            VStack(alignment: .leading, spacing: 2) {
                Text(useHindi ? position.planet.hindiName : position.planet.rawValue)
                    .fontWeight(.medium)
                Text("\(position.sign) \u2022 \(position.displayDegree)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("H\(position.house)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.orange.opacity(0.15))
                    .cornerRadius(6)
                if position.isRetrograde {
                    Text("R")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        KundaliDetailView(kundali: KundaliCalculator.shared.generateKundali(from: BirthDetails(name: "Ram Sharma")))
            .environmentObject(AppState())
    }
}
