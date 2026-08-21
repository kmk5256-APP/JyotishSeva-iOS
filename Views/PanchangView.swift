import SwiftUI

struct PanchangView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedDate = Date()
    
    private var demoPanchang: PanchangData {
        let day = Calendar.current.component(.day, from: selectedDate)
        return PanchangData(
            tithi: ["\u092a\u094d\u0930\u0924\u093f\u092a\u0926\u093e", "\u0926\u094d\u0935\u093f\u0924\u0940\u092f\u093e", "\u0924\u0943\u0924\u0940\u092f\u093e", "\u091a\u0924\u0941\u0930\u094d\u0925\u0940", "\u092a\u0902\u091a\u092e\u0940",
                    "\u0937\u0937\u094d\u0920\u0940", "\u0938\u092a\u094d\u0924\u092e\u0940", "\u0905\u0937\u094d\u091f\u092e\u0940", "\u0928\u0935\u092e\u0940", "\u0926\u0936\u092e\u0940",
                    "\u090f\u0915\u093e\u0926\u0936\u0940", "\u0926\u094d\u0935\u093e\u0926\u0936\u0940", "\u0924\u094d\u0930\u092f\u094b\u0926\u0936\u0940", "\u091a\u0924\u0941\u0930\u094d\u0926\u0936\u0940", "\u092a\u0942\u0930\u094d\u0923\u093f\u092e\u093e"][day % 15],
            tithiEnd: "14:32",
            nakshatra: ["\u0905\u0936\u094d\u0935\u093f\u0928\u0940", "\u092d\u0930\u0923\u0940", "\u0915\u0943\u0924\u094d\u0924\u093f\u0915\u093e", "\u0930\u094b\u0939\u093f\u0923\u0940", "\u092e\u0943\u0917\u0936\u093f\u0930\u093e",
                        "\u0906\u0930\u094d\u0926\u094d\u0930\u093e", "\u092a\u0941\u0928\u0930\u094d\u0935\u0938\u0941", "\u092a\u0941\u0937\u094d\u092f", "\u0906\u0936\u094d\u0932\u0947\u0937\u093e", "\u092e\u0918\u093e"][day % 10],
            nakshatraEnd: "21:15",
            yoga: ["\u0935\u093f\u0937\u094d\u0915\u0902\u092d", "\u092a\u094d\u0930\u0940\u0924\u093f", "\u0906\u092f\u0941\u0937\u094d\u092e\u093e\u0928", "\u0938\u094c\u092d\u093e\u0917\u094d\u092f", "\u0936\u094b\u092d\u0928"][day % 5],
            karana: ["\u092c\u0935", "\u092c\u093e\u0932\u0935", "\u0915\u094c\u0932\u0935", "\u0924\u0948\u0924\u093f\u0932", "\u0917\u0930"][day % 5],
            sunrise: "06:12",
            sunset: "18:48",
            rahuKaal: "10:30 \u2013 12:00",
            abhijitMuhurat: "11:48 \u2013 12:36",
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
                        PanchangRow(title: appState.useHindi ? "\u0935\u093e\u0930" : "Weekday", value: demoPanchang.weekday, icon: "calendar")
                        PanchangRow(title: appState.useHindi ? "\u0924\u093f\u0925\u093f" : "Tithi", value: "\(demoPanchang.tithi) (upto \(demoPanchang.tithiEnd))", icon: "moon.stars")
                        PanchangRow(title: appState.useHindi ? "\u0928\u0915\u094d\u0937\u0924\u094d\u0930" : "Nakshatra", value: "\(demoPanchang.nakshatra) (upto \(demoPanchang.nakshatraEnd))", icon: "sparkles")
                        PanchangRow(title: appState.useHindi ? "\u092f\u094b\u0917" : "Yoga", value: demoPanchang.yoga, icon: "circle.hexagongrid")
                        PanchangRow(title: appState.useHindi ? "\u0915\u0930\u0923" : "Karana", value: demoPanchang.karana, icon: "triangle")
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(appState.useHindi ? "\u0938\u092e\u092f" : "Timings")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            TimingCard(title: appState.useHindi ? "\u0938\u0942\u0930\u094d\u092f\u094b\u0926\u092f" : "Sunrise", value: demoPanchang.sunrise, color: .orange)
                            TimingCard(title: appState.useHindi ? "\u0938\u0942\u0930\u094d\u092f\u093e\u0938\u094d\u0924" : "Sunset", value: demoPanchang.sunset, color: .indigo)
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            TimingCard(title: appState.useHindi ? "\u0930\u093e\u0939\u0941\u0915\u093e\u0932" : "Rahu Kaal", value: demoPanchang.rahuKaal, color: .red)
                            TimingCard(title: appState.useHindi ? "\u0905\u092d\u093f\u091c\u093f\u0924" : "Abhijit", value: demoPanchang.abhijitMuhurat, color: .green)
                        }
                        .padding(.horizontal)
                    }
                    
                    Text(appState.useHindi
                         ? "\u26a0\ufe0f \u0921\u0947\u092e\u094b \u092a\u0902\u091a\u093e\u0902\u0917\u0964 \u0935\u093e\u0938\u094d\u0924\u0935\u093f\u0915 \u0917\u0923\u0928\u093e \u0915\u0947 \u0932\u093f\u090f \u0938\u0939\u0940 \u0907\u0902\u091c\u093f\u0928 \u091c\u094b\u0921\u093c\u0947\u0902\u0964"
                         : "\u26a0\ufe0f Demo Panchang. Integrate real calculation for production.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding()
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(appState.useHindi ? "\u092a\u0902\u091a\u093e\u0902\u0917" : "Panchang")
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
