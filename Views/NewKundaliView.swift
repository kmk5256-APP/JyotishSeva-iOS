import SwiftUI

struct NewKundaliView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var name: String = ""
    @State private var dateOfBirth = Date()
    @State private var timeOfBirth = Date()
    @State private var placeName: String = "New Delhi"
    @State private var showingResult = false
    @State private var generatedKundali: Kundali?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(appState.useHindi ? "\u0928\u093e\u092e" : "Full Name", text: $name)
                        .textInputAutocapitalization(.words)
                } header: {
                    Text(appState.useHindi ? "\u0935\u094d\u092f\u0915\u094d\u0924\u093f \u0915\u093e \u0935\u093f\u0935\u0930\u0923" : "Person Details")
                }
                
                Section {
                    DatePicker(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0924\u093f\u0925\u093f" : "Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    DatePicker(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0938\u092e\u092f" : "Time of Birth", selection: $timeOfBirth, displayedComponents: .hourAndMinute)
                } header: {
                    Text(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0935\u093f\u0935\u0930\u0923" : "Birth Details")
                } footer: {
                    Text(appState.useHindi ? "\u0938\u091f\u0940\u0915 \u0938\u092e\u092f \u0905\u0924\u094d\u092f\u0902\u0924 \u092e\u0939\u0924\u094d\u0935\u092a\u0942\u0930\u094d\u0923 \u0939\u0948" : "Accurate time is extremely important")
                }
                
                Section {
                    TextField(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0938\u094d\u0925\u093e\u0928" : "Place of Birth", text: $placeName)
                } header: {
                    Text(appState.useHindi ? "\u0938\u094d\u0925\u093e\u0928" : "Location")
                }
                
                Section {
                    Button {
                        generate()
                    } label: {
                        HStack {
                            Spacer()
                            Label(appState.useHindi ? "\u0915\u0941\u0902\u0921\u0932\u0940 \u092c\u0928\u093e\u090f\u0901" : "Generate Kundali", systemImage: "sparkles")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .listRowBackground(name.isEmpty ? Color.gray.opacity(0.3) : Color.orange)
                    .foregroundColor(.white)
                }
            }
            .navigationTitle(appState.useHindi ? "\u0928\u0908 \u0915\u0941\u0902\u0921\u0932\u0940" : "New Kundali")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingResult) {
                if let kundali = generatedKundali {
                    NavigationStack {
                        KundaliDetailView(kundali: kundali)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button(appState.useHindi ? "\u092c\u0902\u0926 \u0915\u0930\u0947\u0902" : "Close") {
                                        showingResult = false
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
    
    private func generate() {
        let details = BirthDetails(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            dateOfBirth: dateOfBirth,
            timeOfBirth: timeOfBirth,
            placeName: placeName
        )
        let kundali = KundaliCalculator.shared.generateKundali(from: details)
        generatedKundali = kundali
        appState.addKundali(kundali)
        showingResult = true
    }
}

#Preview {
    NewKundaliView()
        .environmentObject(AppState())
}
