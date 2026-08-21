import Foundation

struct Kundali: Identifiable, Codable {
    let id: UUID
    let birthDetails: BirthDetails
    let lagna: String                 // Ascendant sign
    let moonSign: String
    let sunSign: String
    let nakshatra: String
    let nakshatraLord: String
    let planets: [PlanetPosition]
    let currentDasha: String
    let currentAntardasha: String
    let createdAt: Date
    
    init(
        id: UUID = UUID(),
        birthDetails: BirthDetails,
        lagna: String,
        moonSign: String,
        sunSign: String,
        nakshatra: String,
        nakshatraLord: String,
        planets: [PlanetPosition],
        currentDasha: String,
        currentAntardasha: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.birthDetails = birthDetails
        self.lagna = lagna
        self.moonSign = moonSign
        self.sunSign = sunSign
        self.nakshatra = nakshatra
        self.nakshatraLord = nakshatraLord
        self.planets = planets
        self.currentDasha = currentDasha
        self.currentAntardasha = currentAntardasha
        self.createdAt = createdAt
    }
}
