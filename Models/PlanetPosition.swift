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
        case .sun: return "\u0938\u0942\u0930\u094d\u092f"
        case .moon: return "\u091a\u0902\u0926\u094d\u0930"
        case .mars: return "\u092e\u0902\u0917\u0932"
        case .mercury: return "\u092c\u0941\u0927"
        case .jupiter: return "\u0917\u0941\u0930\u0941"
        case .venus: return "\u0936\u0941\u0915\u094d\u0930"
        case .saturn: return "\u0936\u0928\u093f"
        case .rahu: return "\u0930\u093e\u0939\u0941"
        case .ketu: return "\u0915\u0947\u0924\u0941"
        }
    }
    
    var symbol: String {
        switch self {
        case .sun: return "\u2609"
        case .moon: return "\u263d"
        case .mars: return "\u2642"
        case .mercury: return "\u263f"
        case .jupiter: return "\u2643"
        case .venus: return "\u2640"
        case .saturn: return "\u2644"
        case .rahu: return "\u260a"
        case .ketu: return "\u260b"
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
        String(format: "%.1f\u00b0", degree)
    }
}
