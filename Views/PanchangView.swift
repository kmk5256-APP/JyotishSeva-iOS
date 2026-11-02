import SwiftUI

struct PanchangView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedDate = Date()
    
    private var demoPanchang: PanchangData {
        let day = Calendar.current.component(.day, from: selectedDate)
        return PanchangData(
            tithi: ["\u{092a}\u{094d}\u{0930}\u{0924}\u{093f}\u{092a}\u{0926}\u{093e}", "\u{0926}\u{094d}\u{0935}\u{093f}\u{0924}\u{0940}\u{092f}\u{093e}", "\u{0924}\u{0943}\u{0924}\u{0940}\u{092f}\u{093e}", "\u{091a}\u{0924}\u{0941}\u{0930}\u{094d}\u{0925}\u{0940}", "\u{092a}\u{0902}\u{091a}\u{092e}\u{0940}",
                    "\u{0937}\u{0937}\u{094d}\u{0920}\u{0940}", "\u{0938}\u{092a}\u{094d}\u{0924}\u{092e}\u{0940}", "\u{0905}\u{0937}\u{094d}\u{091f}\u{092e}\u{0940}", "\u{0928}\u{0935}\u{092e}\u{0940}", "\u{0926}\u{0936}\u{092e}\u{0940}",
                    "\u{090f}\u{0915}\u{093e}\u{0926}\u{0936}\u{0940}", "\u{0926}\u{094d}\u{0935}\u{093e}\u{0926}\u{0936}\u{0940}", "\u{0924}\u{094d}\u{0930}\u{092f}\u{094b}\u{0926}\u{0936}\u{0940}", "\u{091a}\u{0924}\u{0941}\u{0930}\u{094d}\u{0926}\u{0936}\u{0940}", "\u{092a}\u{0942}\u{0930}\u{094d}\u{0923}\u{093f}\u{092e}\u{093e}"][day % 15],
            tithiEnd: "14:32",
            nakshatra: ["\u{0905}\u{0936}\u{094d}\u{0935}\u{093f}\u{0928}\u{0940}", "\u{092d}\u{0930}\u{0923}\u{0940}", "\u{0915}\u{0943}\u{0924}\u{094d}\u{0924}\u{093f}\u{0915}\u{093e}", "\u{0930}\u{094b}\u{0939}\u{093f}\u{0923}\u{0940}", "\u{092e}\u{0943}\u{0917}\u{0936}\u{093f}\u{0930}\u{093e}",
                        "\u{0906}\u{0930}\u{094d}\u{0926}\u{094d}\u{0930}\u{093e}", "\u{092a}\u{0941}\u{0928}\u{0930}\u{094d}\u{0935}\u{0938}\u{0941}", "\u{092a}\u{0941}\u{0937}\u{094d}\u{092f}", "\u{0906}\u{0936}\u{094d}\u{0932}\u{0947}\u{0937}\u{093e}", "\u{092e}\u{0918}\u{093e}"][day % 10],
            nakshatraEnd: "21:15",
            yoga: ["\u{0935}\u{093f}\u{0937}\u{094d}\u{0915}\u{0902}\u{092d}", "\u{092a}\u{094d}\u{0930}\u{0940}\u{0924}\u{093f}", "\u{0906}\u{092f}\u{0941}\u{0937}\u{094d}\u{092e}\u{093e}\u{0928}", "\u{0938}\u{094c}\u{092d}\u{093e}\u{0917}\u{094d}\u{092f}", "\u{0936}\u{094b}\u{092d}\u{0928}"][day % 5],
            karana: ["\u{092c}\u{0935}", "\u{092c}\u{093e}\u{0932}\u{0935}", "\u{0915}\u{094c}\u{0932}\u{0935}", "\u{0924}\u{0948}\u{0924}\u{093f}\u{0932}", "\u{0917}\u{0930}"][day % 5],
            sunrise: "06:12",
            sunset: "18:48",
            rahuKaal: "10:30 \u{2013} 12:00",
            abhijitMuhurat: "11:48 \u{2013} 12:36",
            weekday: weekdayName(for: selectedDate)
        )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        PanchangRow(title: appState.useHindi ? "\u{0935}\u{093e}\u{0930}" : "Weekday", value: demoPanchang.weekday, icon: "calendar")
                        PanchangRow(title: appState.useHindi ? "\u{0924}\u{093f}\u{0925}\u{093f}" : "Tithi", value: "\(demoPanchang.tithi) (upto \(demoPanchang.tithiEnd))", icon: "moon.stars")
                        PanchangRow(title: appState.useHindi ? "\u{0928}\u{0915}\u{094d}\u{0937}\u{0924}\u{094d}\u{0930}" : "Nakshatra", value: "\(demoPanchang.nakshatra) (upto \(demoPanchang.nakshatraEnd))", icon: "sparkles")
                        PanchangRow(title: appState.useHindi ? "\u{092f}\u{094b}\u{0917}" : "Yoga", value: demoPanchang.yoga, icon: "circle.hexagongrid")
                        PanchangRow(title: appState.useHindi ? "\u{0915}\u{0930}\u{0923}" : "Karana", value: demoPanchang.karana, icon: "triangle")
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(appState.useHindi ? "\u{0938}\u{092e}\u{092f}" : "Timings")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            TimingCard(title: appState.useHindi ? "\u{0938}\u{0942}\u{0930}\u{094d}\u{092f}\u{094b}\u{0926}\u{092f}" : "Sunrise", value: demoPanchang.sunrise, color: .orange)
                            TimingCard(title: appState.useHindi ? "\u{0938}\u{0942}\u{0930}\u{094d}\u{092f}\u{093e}\u{0938}\u{094d}\u{0924}" : "Sunset", value: demoPanchang.sunset, color: .indigo)
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            TimingCard(title: appState.useHindi ? "\u{0930}\u{093e}\u{0939}\u{0941}\u{0915}\u{093e}\u{0932}" : "Rahu Kaal", value: demoPanchang.rahuKaal, color: .red)
                            TimingCard(title: appState.useHindi ? "\u{0905}\u{092d}\u{093f}\u{091c}\u{093f}\u{0924}" : "Abhijit", value: demoPanchang.abhijitMuhurat, color: .green)
                        }
                        .padding(.horizontal)
                    }
                    
                    Text(appState.useHindi
                         ? "\u{26a0}\u{fe0f} \u{0921}\u{0947}\u{092e}\u{094b} \u{092a}\u{0902}\u{091a}\u{093e}\u{0902}\u{0917}\u{0964} \u{0935}\u{093e}\u{0938}\u{094d}\u{0924}\u{0935}\u{093f}\u{0915} \u{0917}\u{0923}\u{0928}\u{093e} \u{0915}\u{0947} \u{0932}\u{093f}\u{090f} \u{0938}\u{0939}\u{0940} \u{0907}\u{0902}\u{091c}\u{093f}\u{0928} \u{091c}\u{094b}\u{0921}\u{093c}\u{0947}\u{0902}\u{0964}"
                         : "\u{26a0}\u{fe0f} Demo Panchang. Integrate real calculation for production.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding()
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(appState.useHindi ? "\u{092a}\u{0902}\u{091a}\u{093e}\u{0902}\u{0917}" : "Panchang")
        }
    }
    
    private func weekdayName(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: appState.useHindi ? "hi_IN" : "en_IN")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}

struct PanchangData {
    let tithi: String
    let tithiEnd: String
    let nakshatra: String
    let nakshatraEnd: String
    let yoga: String
    let karana: String
    let sunrise: String
    let sunset: String
    let rahuKaal: String
    let abhijitMuhurat: String
    let weekday: String
}

struct PanchangRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption).foregroundColor(.secondary)
                Text(value).font(.body).fontWeight(.medium)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct TimingCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            Text(title).font(.caption).foregroundColor(.secondary)
            Text(value).font(.subheadline).fontWeight(.semibold).foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    PanchangView()
        .environmentObject(AppState())
}
