import SwiftUI

struct MatchingView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var boyName = ""
    @State private var boyDOB = Date()
    @State private var boyTOB = Date()
    @State private var girlName = ""
    @State private var girlDOB = Date()
    @State private var girlTOB = Date()
    
    @State private var result: MatchingResult?
    @State private var showingResult = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(appState.useHindi ? "\u{0932}\u{0921}\u{093c}\u{0915}\u{0947} \u{0915}\u{093e} \u{0928}\u{093e}\u{092e}" : "Boy's Name", text: $boyName)
                    DatePicker(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0924}\u{093f}\u{0925}\u{093f}" : "Date of Birth", selection: $boyDOB, displayedComponents: .date)
                    DatePicker(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0938}\u{092e}\u{092f}" : "Time of Birth", selection: $boyTOB, displayedComponents: .hourAndMinute)
                } header: {
                    Text(appState.useHindi ? "\u{0935}\u{0930} (\u{0932}\u{0921}\u{093c}\u{0915}\u{093e})" : "Groom (Boy)")
                }
                
                Section {
                    TextField(appState.useHindi ? "\u{0932}\u{0921}\u{093c}\u{0915}\u{0940} \u{0915}\u{093e} \u{0928}\u{093e}\u{092e}" : "Girl's Name", text: $girlName)
                    DatePicker(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0924}\u{093f}\u{0925}\u{093f}" : "Date of Birth", selection: $girlDOB, displayedComponents: .date)
                    DatePicker(appState.useHindi ? "\u{091c}\u{0928}\u{094d}\u{092e} \u{0938}\u{092e}\u{092f}" : "Time of Birth", selection: $girlTOB, displayedComponents: .hourAndMinute)
                } header: {
                    Text(appState.useHindi ? "\u{0935}\u{0927}\u{0942} (\u{0932}\u{0921}\u{093c}\u{0915}\u{0940})" : "Bride (Girl)")
                }
                
                Section {
                    Button {
                        calculate()
                    } label: {
                        HStack {
                            Spacer()
                            Label(appState.useHindi ? "\u{092e}\u{093f}\u{0932}\u{093e}\u{0928} \u{0915}\u{0930}\u{0947}\u{0902}" : "Check Matching", systemImage: "heart.fill")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(boyName.isEmpty || girlName.isEmpty)
                    .listRowBackground((boyName.isEmpty || girlName.isEmpty) ? Color.gray.opacity(0.3) : Color.pink)
                    .foregroundColor(.white)
                }
            }
            .navigationTitle(appState.useHindi ? "\u{0915}\u{0941}\u{0902}\u{0921}\u{0932}\u{0940} \u{092e}\u{093f}\u{0932}\u{093e}\u{0928}" : "Kundali Matching")
            .sheet(isPresented: $showingResult) {
                if let result = result {
                    MatchingResultView(result: result)
                }
            }
        }
    }
    
    private func calculate() {
        let boy = BirthDetails(name: boyName, dateOfBirth: boyDOB, timeOfBirth: boyTOB)
        let girl = BirthDetails(name: girlName, dateOfBirth: girlDOB, timeOfBirth: girlTOB)
        result = KundaliCalculator.shared.calculateMatching(boy: boy, girl: girl)
        showingResult = true
    }
}

struct MatchingResultView: View {
    let result: MatchingResult
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 16)
                            .frame(width: 160, height: 160)
                        Circle()
                            .trim(from: 0, to: result.percentage / 100)
                            .stroke(result.isGoodMatch ? Color.green : Color.orange, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                            .frame(width: 160, height: 160)
                            .rotationEffect(.degrees(-90))
                        VStack {
                            Text("\(result.totalScore)")
                                .font(.system(size: 48, weight: .bold))
                            Text("/ 36")
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 20)
                    
                    Text(appState.useHindi ? result.hindiRecommendation : result.recommendation)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack {
                        VStack {
                            Text(result.boyName).fontWeight(.semibold)
                            if result.isManglikBoy {
                                Text(appState.useHindi ? "\u{092e}\u{093e}\u{0902}\u{0917}\u{0932}\u{093f}\u{0915}" : "Manglik").font(.caption).foregroundColor(.red)
                            }
                        }
                        Image(systemName: "heart.fill").foregroundColor(.pink)
                        VStack {
                            Text(result.girlName).fontWeight(.semibold)
                            if result.isManglikGirl {
                                Text(appState.useHindi ? "\u{092e}\u{093e}\u{0902}\u{0917}\u{0932}\u{093f}\u{0915}" : "Manglik").font(.caption).foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(appState.useHindi ? "\u{0905}\u{0937}\u{094d}\u{091f} \u{0915}\u{0942}\u{091f} \u{0935}\u{093f}\u{0935}\u{0930}\u{0923}" : "Ashta Koota Details")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(result.kootas) { koota in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(appState.useHindi ? koota.hindiName : koota.name).fontWeight(.medium)
                                    Text(koota.description).font(.caption2).foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("\(koota.obtained)/\(koota.maxPoints)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(koota.obtained == koota.maxPoints ? .green : .primary)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                    
                    Text(appState.useHindi
                         ? "\u{26a0}\u{fe0f} \u{0921}\u{0947}\u{092e}\u{094b} \u{0938}\u{094d}\u{0915}\u{094b}\u{0930}\u{0964} \u{0935}\u{093e}\u{0938}\u{094d}\u{0924}\u{0935}\u{093f}\u{0915} \u{0917}\u{0923}\u{0928}\u{093e} \u{0915}\u{0947} \u{0932}\u{093f}\u{090f} \u{0938}\u{0939}\u{0940} \u{0907}\u{0902}\u{091c}\u{093f}\u{0928} \u{091c}\u{094b}\u{0921}\u{093c}\u{0947}\u{0902}\u{0964}"
                         : "\u{26a0}\u{fe0f} Demo scores. Integrate real calculation engine for accuracy.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(appState.useHindi ? "\u{092e}\u{093f}\u{0932}\u{093e}\u{0928} \u{092a}\u{0930}\u{093f}\u{0923}\u{093e}\u{092e}" : "Matching Result")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(appState.useHindi ? "\u{092c}\u{0902}\u{0926} \u{0915}\u{0930}\u{0947}\u{0902}" : "Close") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    MatchingView()
        .environmentObject(AppState())
}
