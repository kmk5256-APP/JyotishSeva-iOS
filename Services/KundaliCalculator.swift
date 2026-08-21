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
            KootaScore(name: "Varna", hindiName: "\u0935\u0930\u094d\u0923", maxPoints: 1, obtained: hash % 2, description: "Spiritual compatibility"),
            KootaScore(name: "Vashya", hindiName: "\u0935\u0936\u094d\u092f", maxPoints: 2, obtained: (hash / 2) % 3, description: "Mutual attraction & control"),
            KootaScore(name: "Tara", hindiName: "\u0924\u093e\u0930\u093e", maxPoints: 3, obtained: (hash / 3) % 4, description: "Destiny & health"),
            KootaScore(name: "Yoni", hindiName: "\u092f\u094b\u0928\u093f", maxPoints: 4, obtained: (hash / 5) % 5, description: "Sexual & physical compatibility"),
            KootaScore(name: "Graha Maitri", hindiName: "\u0917\u094d\u0930\u0939 \u092e\u0948\u0924\u094d\u0930\u0940", maxPoints: 5, obtained: (hash / 7) % 6, description: "Mental compatibility"),
            KootaScore(name: "Gana", hindiName: "\u0917\u0923", maxPoints: 6, obtained: (hash / 11) % 7, description: "Temperament"),
            KootaScore(name: "Bhakoot", hindiName: "\u092d\u0915\u0942\u091f", maxPoints: 7, obtained: (hash / 13) % 8, description: "Emotional & family harmony"),
            KootaScore(name: "Nadi", hindiName: "\u0928\u093e\u0921\u093c\u0940", maxPoints: 8, obtained: (hash / 17) % 9, description: "Health & progeny (most important)")
        ]
        
        let total = kootas.reduce(0) { $0 + $1.obtained }
        
        let manglikBoy = (hash % 5 == 0)
        let manglikGirl = (hash % 7 == 0)
        
        let (rec, hindiRec): (String, String)
        if total >= 28 {
            rec = "Excellent match. Highly recommended."
            hindiRec = "\u0909\u0924\u094d\u0924\u092e \u092e\u093f\u0932\u093e\u0928\u0964 \u0905\u0924\u094d\u092f\u0902\u0924 \u0905\u0928\u0941\u0936\u0902\u0938\u093f\u0924\u0964"
        } else if total >= 18 {
            rec = "Good match. Acceptable with minor remedies if needed."
            hindiRec = "\u0905\u091a\u094d\u091b\u093e \u092e\u093f\u0932\u093e\u0928\u0964 \u0906\u0935\u0936\u094d\u092f\u0915\u0924\u093e\u0928\u0941\u0938\u093e\u0930 \u0909\u092a\u093e\u092f \u0915\u0947 \u0938\u093e\u0925 \u0938\u094d\u0935\u0940\u0915\u093e\u0930\u094d\u092f\u0964"
        } else if total >= 12 {
            rec = "Average. Consult senior pandit and consider remedies."
            hindiRec = "\u092e\u0927\u094d\u092f\u092e\u0964 \u0935\u0930\u093f\u0937\u094d\u0920 \u092a\u0902\u0921\u093f\u0924 \u0938\u0947 \u092a\u0930\u093e\u092e\u0930\u094d\u0936 \u0932\u0947\u0902 \u0914\u0930 \u0909\u092a\u093e\u092f \u0915\u0930\u0947\u0902\u0964"
        } else {
            rec = "Low compatibility. Not recommended without strong remedies."
            hindiRec = "\u0915\u092e \u0905\u0928\u0941\u0915\u0942\u0932\u0924\u093e\u0964 \u092e\u091c\u092c\u0942\u0924 \u0909\u092a\u093e\u092f\u094b\u0902 \u0915\u0947 \u092c\u093f\u0928\u093e \u0905\u0928\u0941\u0936\u0902\u0938\u093f\u0924 \u0928\u0939\u0940\u0902\u0964"
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
