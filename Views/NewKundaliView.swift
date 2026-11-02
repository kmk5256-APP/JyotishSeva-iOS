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
                    TextField(appState.useHindi ? "\u{0928}\u{093e}\u{092e}" : "Full Name", text: $name)
                        .textInputAutocapitalization(.words)
                } header: {
                    Text(appState.useHindi ? "\u{0935}\u{094d}\u{092f}\u{0915}\u{094d}\u{0924}\u{093f} \u{0915}\u{093e} \u{0935}\u{093f}\u{0935}\u{0930}\u{0923}" : "Person Details")
                }
                
                Section {
                    DatePicker(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0924}\u{093f}\u{0925}\u{093f}" : "Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    DatePicker(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0938}\u{092e}\u{092f}" : "Time of Birth", selection: $timeOfBirth, displayedComponents: .hourAndMinute)
                } header: {
                    Text(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0935}\u{093f}\u{0935}\u{0930}\u{0923}" : "Birth Details")
                } footer: {
                    Text(appState.useHindi ? "\u{0938}\u{091f}\u{0940}\u{0915} \u{0938}\u{092e}\u{092f} \u{0905}\u{0924}\u{094d}\u{092f}\u{0902}\u{0924} \u{092e}\u{0939}\u{0924}\u{094d}\u{0935}\u{092a}\u{0942}\u{0930}\u{094d}\u{0923} \u{0939}\u{0948}" : "Accurate time is extremely important")
                }
                
                Section {
                    TextField(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0938}\u{094d}\u{0925}\u{093e}\u{0928}" : "Place of Birth", text: $placeName)
                } header: {
                    Text(appState.useHindi ? "\u{0938}\u{094d}\u{0925}\u{093e}\u{0928}" : "Location")
                }
                
                Section {
                    Button {
                        generate()
                    } label: {
                        HStack {
                            Spacer()
                            Label(appState.useHindi ? "\u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{0940} \u{092c}\u{0928}\u{093e}\u{090f}\u{0901}" : "Generate Kundali", systemImage: "sparkles")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .listRowBackground(name.isEmpty ? Color.gray.opacity(0.3) : Color.orange)
                    .foregroundColor(.white)
                }
            }
            .navigationTitle(appState.useHindi ? "\u{0928}\u{0908} \u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{0940}" : "New Kundali")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingResult) {
                if let kundali = generatedKundali {
                    NavigationStack {
                        KundaliDetailView(kundali: kundali)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button(appState.useHindi ? "\u{092c}\u{0902}\u{0926} \u{0915}\u{0930}\u{0947}\u{0902}" : "Close") {
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
