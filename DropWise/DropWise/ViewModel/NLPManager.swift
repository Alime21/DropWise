import Foundation

class NLPManager {
    static let shared = NLPManager()
    
    // ADIM 1: Analiz Kısmı (İsimleri düzelttik)
    func analyzeFarmerInput(_ text: String) -> String {
        let input = text.lowercased()
        
        // Daha hassas eşleşme yapıyoruz
        if input.contains("kuzey") {
            return "Kuzey Tarlası"
        } else if input.contains("yol") || input.contains("kenar") {
            return "Yol Kenarı"
        } else if input.contains("tepe") {
            return "Tepe Mevkii"
        }
        
        return "Genel" // Hiçbiri eşleşmezse
    }
    
    // ADIM 2: Üretim Kısmı (Eşleşmeyi garantiye aldık)
    func generateSmartResponse(for fieldName: String) -> String {
        // Büyük/küçük harf fark etmeksizin listeyi tara
        let field = MockProvider.shared.fields.first {
            $0.name.lowercased() == fieldName.lowercased()
        } ?? MockProvider.shared.fields[0] // Bulamazsa yine 0'a döner, ama artık bulacak!
        
        let waterLimit = 1000.0
        
        let greeting = ["Harika!", "Hemen analiz ediyorum:", "İşte sonuçlar:"].randomElement()!
        
        // Su Tüketimi Analizi
        let analysis = field.waterConsumption > waterLimit ?
            "\(field.name) tarlanızda su tüketimi \(Int(field.waterConsumption))L ile kotayı zorluyor." :
            "\(field.name) tarlanızda su kullanımı oldukça verimli (\(Int(field.waterConsumption))L)."
        
        // Sağlık Durumu Tavsiyesi
        let recommendation = field.healthStatus == "Kritik" ?
            "Acilen damla sulama sistemine geçmenizi öneririm." :
            "Mevcut durum stabil, sulama periyoduna devam edebilirsiniz."
            
        return "\(greeting) \(analysis) \(recommendation)"
    }
}
