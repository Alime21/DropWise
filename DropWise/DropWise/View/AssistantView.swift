import SwiftUI

struct AssistantView: View {
    @State private var isPulsing = false
    
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
                .onAppear {
                    isPulsing = true
                }
                
                VStack(spacing: 10) {
                    Text("Sizi Dinliyorum...")
                        .font(.title)
                        .bold()
                    
                    Text("Hangi tarlanız için optimizasyon yapmak istersiniz?")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                
                Spacer()
                
                // Simülasyon Butonu (Sonuç ekranına bağlar)
                NavigationLink(destination: OptimizationResultView()) {
                    HStack {
                        Image(systemName: "cpu")
                        Text("Yapay Zeka Analizini Başlat")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("DropWise Asistan")
        }
    }
}

#Preview {
    AssistantView()
}
