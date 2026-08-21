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
                    TextField(appState.useHindi ? "\u0932\u0921\u093c\u0915\u0947 \u0915\u093e \u0928\u093e\u092e" : "Boy's Name", text: $boyName)
                    DatePicker(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0924\u093f\u0925\u093f" : "Date of Birth", selection: $boyDOB, displayedComponents: .date)
                    DatePicker(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0938\u092e\u092f" : "Time of Birth", selection: $boyTOB, displayedComponents: .hourAndMinute)
                } header: {
                    Text(appState.useHindi ? "\u0935\u0930 (\u0932\u0921\u093c\u0915\u093e)" : "Groom (Boy)")
                }
                
                Section {
                    TextField(appState.useHindi ? "\u0932\u0921\u093c\u0915\u0940 \u0915\u093e \u0928\u093e\u092e" : "Girl's Name", text: $girlName)
                    DatePicker(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0924\u093f\u0925\u093f" : "Date of Birth", selection: $girlDOB, displayedComponents: .date)
                    DatePicker(appState.useHindi ? "\u091c\u0928\u094d\u092e \u0938\u092e\u092f" : "Time of Birth", selection: $girlTOB, displayedComponents: .hourAndMinute)
                } header: {
                    Text(appState.useHindi ? "\u0935\u0927\u0942 (\u0932\u0921\u093c\u0915\u0940)" : "Bride (Girl)")
                }
                
                Section {
                    Button {
                        calculate()
                    } label: {
                        HStack {
                            Spacer()
                            Label(appState.useHindi ? "\u092e\u093f\u0932\u093e\u0928 \u0915\u0930\u0947\u0902" : "Check Matching", systemImage: "heart.fill")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(boyName.isEmpty || girlName.isEmpty)
                    .listRowBackground((boyName.isEmpty || girlName.isEmpty) ? Color.gray.opacity(0.3) : Color.pink)
                    .foregroundColor(.white)
                }
            }
            .navigationTitle(appState.useHindi ? "\u0915\u0941\u0902\u0921\u0932\u0940 \u092e\u093f\u0932\u093e\u0928" : "Kundali Matching")
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
                                Text(appState.useHindi ? "\u092e\u093e\u0902\u0917\u0932\u093f\u0915" : "Manglik").font(.caption).foregroundColor(.red)
                            }
                        }
                        Image(systemName: "heart.fill").foregroundColor(.pink)
                        VStack {
                            Text(result.girlName).fontWeight(.semibold)
                            if result.isManglikGirl {
                                Text(appState.useHindi ? "\u092e\u093e\u0902\u0917\u0932\u093f\u0915" : "Manglik").font(.caption).foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(appState.useHindi ? "\u0905\u0937\u094d\u091f \u0915\u0942\u091f \u0935\u093f\u0935\u0930\u0923" : "Ashta Koota Details")
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
                         ? "\u26a0\ufe0f \u0921\u0947\u092e\u094b \u0938\u094d\u0915\u094b\u0930\u0964 \u0935\u093e\u0938\u094d\u0924\u0935\u093f\u0915 \u0917\u0923\u0928\u093e \u0915\u0947 \u0932\u093f\u090f \u0938\u0939\u0940 \u0907\u0902\u091c\u093f\u0928 \u091c\u094b\u0921\u093c\u0947\u0902\u0964"
                         : "\u26a0\ufe0f Demo scores. Integrate real calculation engine for accuracy.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(appState.useHindi ? "\u092e\u093f\u0932\u093e\u0928 \u092a\u0930\u093f\u0923\u093e\u092e" : "Matching Result")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(appState.useHindi ? "\u092c\u0902\u0926 \u0915\u0930\u0947\u0902" : "Close") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    MatchingView()
        .environmentObject(AppState())
}
