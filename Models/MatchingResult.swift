import Foundation

struct KootaScore: Identifiable {
    let id = UUID()
    let name: String
    let hindiName: String
    let maxPoints: Int
    let obtained: Int
    let description: String
}

struct MatchingResult: Identifiable {
    let id = UUID()
    let boyName: String
    let girlName: String
    let totalScore: Int          // out of 36
    let kootas: [KootaScore]
    let isManglikBoy: Bool
    let isManglikGirl: Bool
    let recommendation: String
    let hindiRecommendation: String
    
    var percentage: Double {
        Double(totalScore) / 36.0 * 100.0
    }
    
    var isGoodMatch: Bool {
        totalScore >= 18
    }
}
