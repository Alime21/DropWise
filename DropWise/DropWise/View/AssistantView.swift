import SwiftUI

struct AssistantView: View {
    @State private var isPulsing = false
    @State private var farmerInput = "" // Çiftçinin yazdığı/söylediği metin
    @State private var showResult = false // Sonuç ekranını açma kontrolü
    @State private var smartSpeech = "" // NLG tarafından üretilen cümle
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()
                
                // Animasyonlu Mikrofon
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: isPulsing ? 200 : 150, height: isPulsing ? 200 : 150)
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: isPulsing)
                    
                    Circle()
                        .fill(Color.blue.opacity(0.4))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "mic.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                }
                .onAppear { isPulsing = true }
                
                VStack(spacing: 15) {
                    Text("Sizi Dinliyorum...")
                        .font(.title).bold()
                    
                    TextField("Örn: Kuzey tarlasında ne ekili?", text: $farmerInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                }
                
                Spacer()
                
                // ANALİZ VE ÜRETİM BUTONU
                Button(action: {
                    // --- ADIM 1: NLP (Metni Anla) ---
                    // Burada 'result' değişkenini tanımlıyoruz
                    let detectedName = NLPManager.shared.analyzeFarmerInput(farmerInput)
                    
                    // --- ADIM 2: NLG (Cümle Üret) ---
                    // Az önce tanımladığımız 'analysisResult' içindeki veriyi kullanıyoruz
                    let finalSpeech = NLPManager.shared.generateSmartResponse(for: detectedName)
                        
                    // --- ADIM 3: STATE GÜNCELLE ---
                    self.smartSpeech = finalSpeech
                    self.showResult = true
                }) {
                    HStack {
                        Image(systemName: "cpu")
                        Text("Akıllı Analizi Başlat")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(farmerInput.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                }
                .disabled(farmerInput.isEmpty)
                .padding(.bottom, 20)
                
                // SONUÇ EKRANINA YÖNLENDİRME
                NavigationLink(
                    destination: ResultDetailView(message: smartSpeech),
                    isActive: $showResult,
                    label: { EmptyView() }
                )
            }
            .navigationTitle("DropWise Asistan")
        }
    }
}

// Sonucu gösteren basit bir alt görünüm
struct ResultDetailView: View {
    let message: String
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "sparkles")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text(message)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .navigationTitle("YZ Analiz Sonucu")
    }
}
