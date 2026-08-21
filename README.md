# JyotishSeva-iOS

**Native SwiftUI iOS app for Hindu Priests (Pandits)**

A clean, respectful, offline-first app designed specifically for Indian Hindu priests to:

- Generate Vedic Kundali (birth chart)
- View planetary positions, Lagna, Nakshatra, and Vimshottari Dasha
- Perform Ashta Koota (Guna Milan) kundali matching
- Check daily Panchang & important muhurats
- Keep simple client notes

Built with **SwiftUI** for modern iOS (iOS 17+).

> **Important**: This is a well-structured **starter / production-ready scaffold**.  
> Real planetary calculations require a proper ephemeris engine (Swiss Ephemeris or a licensed Jyotish API).  
> The current calculator returns **demo/mock data** so you can immediately run the UI and replace the calculation layer later.

---

## Features

| Feature | Status | Notes |
|---------|--------|-------|
| Birth details input | ✅ Ready | Name, DOB, TOB, Place |
| Kundali display | ✅ Ready | Lagna, Rashi, Planets, Dasha (mock) |
| Ashta Koota Matching | ✅ Ready | Full 36-point system with breakdown |
| Daily Panchang | ✅ Ready | Tithi, Nakshatra, Yoga, Karana, Rahu Kaal |
| Hindi + English | ✅ Ready | Toggle in settings |
| Client notes | ✅ Basic | Local storage |
| Print / Share PDF | 🔄 Planned | Easy to add |
| Real Swiss Ephemeris | 🔄 TODO | Replace `KundaliCalculator` |

---

## Project Structure

```
JyotishSeva-iOS/
├── JyotishSevaApp.swift          # App entry point
├── ContentView.swift             # Root TabView
├── Models/
│   ├── BirthDetails.swift
│   ├── Kundali.swift
│   ├── PlanetPosition.swift
│   └── MatchingResult.swift
├── Views/
│   ├── HomeView.swift
│   ├── NewKundaliView.swift
│   ├── KundaliDetailView.swift
│   ├── MatchingView.swift
│   ├── PanchangView.swift
│   └── Components/
├── Services/
│   └── KundaliCalculator.swift   # ← Replace this with real engine
└── LICENSE
```

---

## How to Run

1. Open **Xcode 15+** on a Mac.
2. Create a new **iOS App** project:
   - Product Name: `JyotishSeva`
   - Interface: **SwiftUI**
   - Language: **Swift**
3. Delete the default `ContentView.swift` and App file.
4. Drag all the `.swift` files from this repository into your Xcode project (preserve the folder groups: Models, Views, Services).
5. Build & Run on simulator or device (iOS 17+).

---

## Next Steps for Production

1. **Replace calculation engine**  
   Integrate [Swiss Ephemeris](https://www.astro.com/swisseph/) via a Swift wrapper or a trusted Jyotish API.

2. **Add place search**  
   Use MapKit or geocoding for accurate latitude/longitude and timezone.

3. **Offline storage**  
   Persist client kundalis with SwiftData or Core Data.

4. **PDF Report**  
   Generate printable kundali using PDFKit.

5. **App Store**  
   - Privacy policy (required)
   - Full Hindi localization
   - Respectful app icon & screenshots

---

## Design Principles

- Large, readable fonts (suitable for temple use and older eyes)
- High contrast, calm saffron/cream color palette
- Minimal distractions – focus on accurate data presentation
- Fully offline capable once calculation engine is local

---

## License

MIT License – free for personal and commercial use by priests and developers.

---

**Jai Shri Krishna**  
Built with deep respect for the ancient science of Jyotish.
