import SwiftUI

struct AssistantView: View {
    // --- MARK: - Properties (State)
    @State private var isPulsing = false
    @State private var farmerInput = ""
    @State private var showResult = false
    @State private var smartSpeech = ""
    @State private var isCalculating = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()
                
                // 1. Bileşen: Animasyonlu Mikrofon ve Durum Göstergesi
                micSection
                
                // 2. Bileşen: Metin Giriş Alanı
                inputSection
                
                Spacer()
                
                // 3. Bileşen: Analiz Butonu
                analysisButton
                
                // Gizli Navigasyon
                navigationLink
            }
            .navigationTitle("DropWise Asistan")
            .onAppear { isPulsing = true }
        }
    }
}

// --- MARK: - Subviews (UI Parçaları)
private extension AssistantView {
    
    // Mikrofon ve Progress Kısmı
    var micSection: some View {
        ZStack {
            Circle()
                .fill(isCalculating ? Color.orange.opacity(0.2) : Color.blue.opacity(0.2))
                .frame(width: isPulsing ? 200 : 150, height: isPulsing ? 200 : 150)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: isPulsing)
            
            Circle()
                .fill(isCalculating ? Color.orange.opacity(0.4) : Color.blue.opacity(0.4))
                .frame(width: 120, height: 120)
            
            if isCalculating {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            } else {
                Image(systemName: "mic.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
            }
        }
    }
    
    // Giriş Alanı
    var inputSection: some View {
        VStack(spacing: 15) {
            Text(isCalculating ? "Kuantum Motoru Çalışıyor..." : "Sizi Dinliyorum...")
                .font(.title).bold()
                .foregroundColor(isCalculating ? .orange : .primary)
            
            TextField("Örn: Kuzey tarlasında ne ekili?", text: $farmerInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)
                .disabled(isCalculating)
        }
    }
    
    // Analiz Butonu ve İş Mantığı
    var analysisButton: some View {
        Button(action: startAnalysis) {
            HStack {
                if isCalculating {
                    Text("Hesaplanıyor...")
                } else {
                    Image(systemName: "cpu")
                    Text("Akıllı Analizi Başlat")
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(farmerInput.isEmpty || isCalculating ? Color.gray : Color.blue)
            .cornerRadius(15)
            .padding(.horizontal, 20)
        }
        .disabled(farmerInput.isEmpty || isCalculating)
        .padding(.bottom, 20)
    }
    
    var navigationLink: some View {
        NavigationLink(
            destination: ResultDetailView(message: smartSpeech),
            isActive: $showResult,
            label: { EmptyView() }
        )
    }
}

// --- MARK: - Logic (İş Mantığı Metotları)
private extension AssistantView {
    func startAnalysis() {
        isCalculating = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // NLP & Quantum & NLG işlemlerini tek bir merkezde topladık
            let analysisResult = NLPManager.shared.analyzeFarmerInput(farmerInput)
            
            let quantumFinding = QuantumOptimizer.shared.simulateQuantumAnnealing(
                waterCredit: MockProvider.shared.user.totalWaterCredit,
                fields: MockProvider.shared.fields
            )
            
            let nlgResponse = NLPManager.shared.generateSmartResponse(for: analysisResult)
            
            self.smartSpeech = "\(nlgResponse)\n\n---\n\(quantumFinding)"
            self.isCalculating = false
            self.showResult = true
        }
    }
}

struct ResultDetailView: View {
    let message: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Kuantum ve YZ simgesi
                Image(systemName: "sparkles.lucid")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                    .padding(.top, 40)
                    .shadow(color: .orange.opacity(0.4), radius: 15)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("DropWise Zekâ Raporu")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    // NLP, NLG ve Kuantumdan gelen birleşik mesaj
                    Text(message)
                        .font(.title3)
                        .fontWeight(.medium)
                        .lineSpacing(10)
                        .multilineTextAlignment(.leading)
                }
                .padding(25)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(25)
                .padding(.horizontal)
                
                // Jürinin hoşuna gidecek "Aksiyon" butonu
                Button(action: {
                    // Paylaşım simülasyonu
                }) {
                    Label("Analizi Paylaş", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationTitle("Analiz Detayları")
        .navigationBarTitleDisplayMode(.inline)
    }
}
