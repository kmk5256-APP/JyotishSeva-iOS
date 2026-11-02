import Foundation

/// Stub calculator that returns realistic demo data.
/// Replace this entire class with a real Swiss Ephemeris wrapper or API client
/// when moving to production.
final class KundaliCalculator {
    
    static let shared = KundaliCalculator()
    
    private init() {}
    
    // MARK: - Public API
    
    func generateKundali(from details: BirthDetails) -> Kundali {
        // In production: call Swiss Ephemeris here with precise lat/long/time
        // For now we return consistent demo data based on name hash for variety
        
        let signs = ["Mesha (Aries)", "Vrishabha (Taurus)", "Mithuna (Gemini)",
                     "Karka (Cancer)", "Simha (Leo)", "Kanya (Virgo)",
                     "Tula (Libra)", "Vrishchika (Scorpio)", "Dhanu (Sagittarius)",
                     "Makara (Capricorn)", "Kumbha (Aquarius)", "Meena (Pisces)"]
        
        let nakshatras = ["Ashwini", "Bharani", "Krittika", "Rohini", "Mrigashira",
                          "Ardra", "Punarvasu", "Pushya", "Ashlesha", "Magha",
                          "Purva Phalguni", "Uttara Phalguni", "Hasta", "Chitra",
                          "Swati", "Vishakha", "Anuradha", "Jyeshtha", "Mula",
                          "Purva Ashadha", "Uttara Ashadha", "Shravana", "Dhanishta",
                          "Shatabhisha", "Purva Bhadrapada", "Uttara Bhadrapada", "Revati"]
        
        let hash = abs(details.name.hashValue)
        let lagnaIndex = hash % 12
        let moonIndex = (hash / 3) % 12
        let sunIndex = (hash / 7) % 12
        let nakIndex = hash % 27
        
        let planets: [PlanetPosition] = Planet.allCases.enumerated().map { index, planet in
            let signIdx = (lagnaIndex + index * 2) % 12
            let house = ((index + lagnaIndex) % 12) + 1
            return PlanetPosition(
                planet: planet,
                sign: signs[signIdx],
                degree: Double((hash + index * 17) % 300) / 10.0,
                house: house,
                isRetrograde: planet == .mercury || planet == .venus || planet == .saturn ? (hash % 3 == 0) : false,
                nakshatra: nakshatras[(nakIndex + index) % 27],
                pada: (index % 4) + 1
            )
        }
        
        let dashaLords = ["Ketu", "Venus", "Sun", "Moon", "Mars", "Rahu", "Jupiter", "Saturn", "Mercury"]
        let dasha = dashaLords[hash % 9]
        let antardasha = dashaLords[(hash / 2) % 9]
        
        return Kundali(
            birthDetails: details,
            lagna: signs[lagnaIndex],
            moonSign: signs[moonIndex],
            sunSign: signs[sunIndex],
            nakshatra: nakshatras[nakIndex],
            nakshatraLord: dashaLords[nakIndex % 9],
            planets: planets,
            currentDasha: "\(dasha) Mahadasha",
            currentAntardasha: "\(antardasha) Antardasha"
        )
    }
    
    func calculateMatching(boy: BirthDetails, girl: BirthDetails) -> MatchingResult {
        // Demo Ashta Koota scores – replace with real calculation
        let hash = abs(boy.name.hashValue &+ girl.name.hashValue)
        
        let kootas: [KootaScore] = [
            KootaScore(name: "Varna", hindiName: "\u{0935}\u{0930}\u{094d}\u{0923}", maxPoints: 1, obtained: hash % 2, description: "Spiritual compatibility"),
            KootaScore(name: "Vashya", hindiName: "\u{0935}\u{0936}\u{094d}\u{092f}", maxPoints: 2, obtained: (hash / 2) % 3, description: "Mutual attraction & control"),
            KootaScore(name: "Tara", hindiName: "\u{0924}\u{093e}\u{0930}\u{093e}", maxPoints: 3, obtained: (hash / 3) % 4, description: "Destiny & health"),
            KootaScore(name: "Yoni", hindiName: "\u{092f}\u{094b}\u{0928}\u{093f}", maxPoints: 4, obtained: (hash / 5) % 5, description: "Sexual & physical compatibility"),
            KootaScore(name: "Graha Maitri", hindiName: "\u{0917}\u{094d}\u{0930}\u{0939} \u{092e}\u{0948}\u{0924}\u{094d}\u{0930}\u{0940}", maxPoints: 5, obtained: (hash / 7) % 6, description: "Mental compatibility"),
            KootaScore(name: "Gana", hindiName: "\u{0917}\u{0923}", maxPoints: 6, obtained: (hash / 11) % 7, description: "Temperament"),
            KootaScore(name: "Bhakoot", hindiName: "\u{092d}\u{0915}\u{0942}\u{091f}", maxPoints: 7, obtained: (hash / 13) % 8, description: "Emotional & family harmony"),
            KootaScore(name: "Nadi", hindiName: "\u{0928}\u{093e}\u{0921}\u{093c}\u{0940}", maxPoints: 8, obtained: (hash / 17) % 9, description: "Health & progeny (most important)")
        ]
        
        let total = kootas.reduce(0) { $0 + $1.obtained }
        
        let manglikBoy = (hash % 5 == 0)
        let manglikGirl = (hash % 7 == 0)
        
        let (rec, hindiRec): (String, String)
        if total >= 28 {
            rec = "Excellent match. Highly recommended."
            hindiRec = "\u{0909}\u{0924}\u{094d}\u{0924}\u{092e} \u{092e}\u{093f}\u{0932}\u{093e}\u{0928}\u{0964} \u{0905}\u{0924}\u{094d}\u{092f}\u{0902}\u{0924} \u{0905}\u{0928}\u{0941}\u{0936}\u{0902}\u{0938}\u{093f}\u{0924}\u{0964}"
        } else if total >= 18 {
            rec = "Good match. Acceptable with minor remedies if needed."
            hindiRec = "\u{0905}\u{091a}\u{094d}\u{091b}\u{093e} \u{092e}\u{093f}\u{0932}\u{093e}\u{0928}\u{0964} \u{0906}\u{0935}\u{0936}\u{094d}\u{092f}\u{0915}\u{0924}\u{093e}\u{0928}\u{0941}\u{0938}\u{093e}\u{0930} \u{0909}\u{092a}\u{093e}\u{092f} \u{0915}\u{0947} \u{0938}\u{093e}\u{0925} \u{0938}\u{094d}\u{0935}\u{0940}\u{0915}\u{093e}\u{0930}\u{094d}\u{092f}\u{0964}"
        } else if total >= 12 {
            rec = "Average. Consult senior pandit and consider remedies."
            hindiRec = "\u{092e}\u{0927}\u{094d}\u{092f}\u{092e}\u{0964} \u{0935}\u{0930}\u{093f}\u{0937}\u{094d}\u{0920} \u{092a}\u{0902}\u{0921}\u{093f}\u{0924} \u{0938}\u{0947} \u{092a}\u{0930}\u{093e}\u{092e}\u{0930}\u{094d}\u{0936} \u{0932}\u{0947}\u{0902} \u{0914}\u{0930} \u{0909}\u{092a}\u{093e}\u{092f} \u{0915}\u{0930}\u{0947}\u{0902}\u{0964}"
        } else {
            rec = "Low compatibility. Not recommended without strong remedies."
            hindiRec = "\u{0915}\u{092e} \u{0905}\u{0928}\u{0941}\u{0915}\u{0942}\u{0932}\u{0924}\u{093e}\u{0964} \u{092e}\u{091c}\u{092c}\u{0942}\u{0924} \u{0909}\u{092a}\u{093e}\u{092f}\u{094b}\u{0902} \u{0915}\u{0947} \u{092c}\u{093f}\u{0928}\u{093e} \u{0905}\u{0928}\u{0941}\u{0936}\u{0902}\u{0938}\u{093f}\u{0924} \u{0928}\u{0939}\u{0940}\u{0902}\u{0964}"
        }
        
        return MatchingResult(
            boyName: boy.name,
            girlName: girl.name,
            totalScore: total,
            kootas: kootas,
            isManglikBoy: manglikBoy,
            isManglikGirl: manglikGirl,
            recommendation: rec,
            hindiRecommendation: hindiRec
        )
    }
}
