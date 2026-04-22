import SwiftUI

struct FieldsView: View {
    // Veriyi direkt ViewModel/MockProvider'dan çekiyoruz
    let fields = MockProvider.shared.fields
    
    var body: some View {
        NavigationView {
            List(fields) { field in
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Üst Satır: Tarla Adı ve Sağlık Durumu
                    HStack {
                        Text(field.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        // "health" yerine "healthStatus" kullanıyoruz
                        Text(field.healthStatus)
                            .font(.caption)
                            .bold()
                            .foregroundColor(field.healthStatus == "İyi" ? .green : (field.healthStatus == "Kritik" ? .red : .orange))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(field.healthStatus == "İyi" ? Color.green.opacity(0.2) : (field.healthStatus == "Kritik" ? Color.red.opacity(0.2) : Color.orange.opacity(0.2)))
                            .cornerRadius(10)
                    }
                    
                    // Alt Satır: Ekili Ürün ve Su Tüketimi
                    HStack {
                        Label(field.currentCrop, systemImage: "leaf.fill")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        // "waterUsage" yerine "waterConsumption" kullanıyoruz
                        Label("\(Int(field.waterConsumption)) L", systemImage: "drop.fill")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Tarlalarım")
            // Listeyi modern iOS görünümüne çevirir
            .listStyle(InsetGroupedListStyle())
        }
    }
}

#Preview {
    FieldsView()
}
