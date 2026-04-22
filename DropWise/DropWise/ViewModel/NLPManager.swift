import Foundation

// NLP'nin analiz sonucunu tutacak yapı
struct NLPResult {
    let intent: String      // Niyet (Örn: "Tavsiye", "Bilgi")
    let targetField: String // Hedef Tarla
    let recommendation: String // Yapay Zeka Cevabı
}

class NLPManager {
    static let shared = NLPManager()
    
    // Basit bir Kural Tabanlı (Rule-based) NLP Simülasyonu
    func analyzeFarmerInput(_ text: String) -> NLPResult {
        let lowercasedText = text.lowercased()
        
        // 1. Entity Extraction (Varlık Çıkarımı) - Hangi tarla?
        var detectedField = "Genel"
        if lowercasedText.contains("kuzey") || lowercasedText.contains("tepe") {
            detectedField = "Kuzey Tarlası"
        } else if lowercasedText.contains("yol") {
            detectedField = "Yol Kenarı"
        }
        
        // 2. Intent Classification (Niyet Sınıflandırması) - Ne istiyor?
        if lowercasedText.contains("ne ekmeliyim") || lowercasedText.contains("tavsiye") || lowercasedText.contains("öneri") {
            
            return NLPResult(
                intent: "Tavsiye İstemi",
                targetField: detectedField,
                recommendation: "Bölgenizdeki kuraklık riski nedeniyle bu sezon su tüketimi düşük olan Arpa ekmeniz %45 su tasarrufu sağlayacaktır."
            )
            
        } else if lowercasedText.contains("su") || lowercasedText.contains("kredi") {
            
            return NLPResult(
                intent: "Su Durumu Sorgusu",
                targetField: detectedField,
                recommendation: "Mevcut su krediniz kritik seviyede. Lütfen sulama sistemlerinizi gece saatlerine göre optimize edin."
            )
            
        } else {
            // Anlaşılamayan durumlar için Fallback (Güvenlik ağı)
            return NLPResult(
                intent: "Genel Analiz",
                targetField: "Tüm Tarlalar",
                recommendation: "Tarlalarınızın genel sağlık durumu iyi. Düzenli sulama planınıza devam edebilirsiniz."
            )
        }
    }
}

