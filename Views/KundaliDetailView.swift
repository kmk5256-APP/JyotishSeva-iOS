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
                    Text("\(kundali.birthDetails.formattedDate) \u{2022} \(kundali.birthDetails.formattedTime)")
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
                    InfoCard(title: appState.useHindi ? "\u{0932}\u{0917}\u{094d}\u{0928}" : "Lagna", value: kundali.lagna)
                    InfoCard(title: appState.useHindi ? "\u{0930}\u{093e}\u{0936}\u{093f}" : "Moon Sign", value: kundali.moonSign)
                    InfoCard(title: appState.useHindi ? "\u{0928}\u{0915}\u{094d}\u{0937}\u{0924}\u{094d}\u{0930}" : "Nakshatra", value: kundali.nakshatra)
                    InfoCard(title: appState.useHindi ? "\u{0928}\u{0915}\u{094d}\u{0937}\u{0924}\u{094d}\u{0930} \u{0938}\u{094d}\u{0935}\u{093e}\u{092e}\u{0940}" : "Nakshatra Lord", value: kundali.nakshatraLord)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(appState.useHindi ? "\u{0935}\u{0930}\u{094d}\u{0924}\u{092e}\u{093e}\u{0928} \u{0926}\u{0936}\u{093e}" : "Current Dasha")
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
                    Text(appState.useHindi ? "\u{0917}\u{094d}\u{0930}\u{0939} \u{0938}\u{094d}\u{0925}\u{093f}\u{0924}\u{093f}" : "Planetary Positions")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(kundali.planets) { position in
                        PlanetRow(position: position, useHindi: appState.useHindi)
                    }
                }
                
                Text(appState.useHindi
                     ? "\u{26a0}\u{fe0f} \u{092f}\u{0939} \u{0921}\u{0947}\u{092e}\u{094b} \u{0921}\u{0947}\u{091f}\u{093e} \u{0939}\u{0948}\u{0964} \u{0935}\u{093e}\u{0938}\u{094d}\u{0924}\u{0935}\u{093f}\u{0915} \u{0917}\u{0923}\u{0928}\u{093e} \u{0915}\u{0947} \u{0932}\u{093f}\u{090f} Swiss Ephemeris \u{091c}\u{094b}\u{0921}\u{093c}\u{0947}\u{0902}\u{0964}"
                     : "\u{26a0}\u{fe0f} Demo data only. Integrate Swiss Ephemeris for production accuracy.")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(appState.useHindi ? "\u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{0940}" : "Kundali")
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
                Text("\(position.sign) \u{2022} \(position.displayDegree)")
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
