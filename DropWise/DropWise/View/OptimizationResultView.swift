import SwiftUI

struct OptimizationResultView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Başarı İkonu ve Başlık
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                    
                    Text("Analiz Tamamlandı")
                        .font(.title2)
                        .bold()
                    
                    Text("Tepe Mevkii tarlanız için en uygun ürün belirlendi.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // Tavsiye Kartı
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "sparkles")
                            .foregroundColor(.orange)
                        Text("Yapay Zeka Tavsiyesi")
                            .font(.headline)
                    }
                    
                    Text("Mevcut su krediniz ve bölgenizdeki kuraklık risk haritası göz önüne alındığında, bu sezon **Arpa** ekmeniz önerilmektedir.")
                        .font(.body)
                    
                    Divider()
                    
                    // Kazanım Özeti
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Su Tasarrufu")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("%45")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Risk Durumu")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("Düşük")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.green)
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                .padding(.horizontal)
                
                Spacer()
                
                // Onay Butonu
                Button(action: {
                    // Gelecekte planı kaydetme işlevi buraya gelecek
                }) {
                    Text("Planı Uygula ve Krediyi Güncelle")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Optimizasyon Raporu")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    OptimizationResultView()
}
