import SwiftUI

struct AssistantView: View {
    @State private var isPulsing = false
    @State private var farmerInput = ""
    @State private var showResult = false
    @State private var nlpResult: NLPResult?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()
                
                // Dinamik Mikrofon İkonu
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
                        .font(.title)
                        .bold()
                    
                    // Jürinin önünde şov yapacağımız sahte giriş alanı (Gerçekte sesle dolacak)
                    TextField("Örn: Kuzey tarlasına ne ekmeliyim?", text: $farmerInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                }
                
                Spacer()
                
                // Analiz Butonu
                Button(action: {
                    // NLP Motorunu Çalıştır
                    nlpResult = NLPManager.shared.analyzeFarmerInput(farmerInput)
                    showResult = true
                }) {
                    HStack {
                        Image(systemName: "cpu")
                        Text("Söylemi Analiz Et (NLP)")
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
                
                // Gizli Yönlendirme (NavigationLink)
                NavigationLink(
                    destination: Text(nlpResult?.recommendation ?? "Hata").padding(), // Şimdilik basit text, sonra o havalı sayfaya bağlarız
                    isActive: $showResult,
                    label: { EmptyView() }
                )
            }
            .navigationTitle("DropWise Asistan")
        }
    }
}

#Preview {
    AssistantView()
}
