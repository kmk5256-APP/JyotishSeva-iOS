import Foundation

enum Planet: String, CaseIterable, Codable, Identifiable {
    case sun = "Sun"
    case moon = "Moon"
    case mars = "Mars"
    case mercury = "Mercury"
    case jupiter = "Jupiter"
    case venus = "Venus"
    case saturn = "Saturn"
    case rahu = "Rahu"
    case ketu = "Ketu"
    
    var id: String { rawValue }
    
    var hindiName: String {
        switch self {
        case .sun: return "\u{0938}\u{0942}\u{0930}\u{094d}\u{092f}"
        case .moon: return "\u{091a}\u{0902}\u{0926}\u{094d}\u{0930}"
        case .mars: return "\u{092e}\u{0902}\u{0917}\u{0932}"
        case .mercury: return "\u{092c}\u{0941}\u{0927}"
        case .jupiter: return "\u{0917}\u{0941}\u{0930}\u{0941}"
        case .venus: return "\u{0936}\u{0941}\u{0915}\u{094d}\u{0930}"
        case .saturn: return "\u{0936}\u{0928}\u{093f}"
        case .rahu: return "\u{0930}\u{093e}\u{0939}\u{0941}"
        case .ketu: return "\u{0915}\u{0947}\u{0924}\u{0941}"
        }
    }
    
    var symbol: String {
        switch self {
        case .sun: return "\u{2609}"
        case .moon: return "\u{263d}"
        case .mars: return "\u{2642}"
        case .mercury: return "\u{263f}"
        case .jupiter: return "\u{2643}"
        case .venus: return "\u{2640}"
        case .saturn: return "\u{2644}"
        case .rahu: return "\u{260a}"
        case .ketu: return "\u{260b}"
        }
    }
}

struct PlanetPosition: Identifiable, Codable {
    let id = UUID()
    let planet: Planet
    let sign: String          // e.g. "Mesha (Aries)"
    let degree: Double        // 0–30 within sign
    let house: Int            // 1–12
    let isRetrograde: Bool
    let nakshatra: String
    let pada: Int
    
    var displayDegree: String {
        String(format: "%.1f\u{00b0}", degree)
    }
}
