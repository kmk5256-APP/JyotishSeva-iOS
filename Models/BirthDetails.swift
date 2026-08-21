import Foundation

struct BirthDetails: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var dateOfBirth: Date
    var timeOfBirth: Date
    var placeName: String
    var latitude: Double
    var longitude: Double
    var timezoneOffset: Double // hours from UTC
    
    init(
        id: UUID = UUID(),
        name: String = "",
        dateOfBirth: Date = Date(),
        timeOfBirth: Date = Date(),
        placeName: String = "New Delhi",
        latitude: Double = 28.6139,
        longitude: Double = 77.2090,
        timezoneOffset: Double = 5.5
    ) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.timeOfBirth = timeOfBirth
        self.placeName = placeName
        self.latitude = latitude
        self.longitude = longitude
        self.timezoneOffset = timezoneOffset
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: dateOfBirth)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: timeOfBirth)
    }
}
