import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // 1. Ana Ekran
            DashboardView()
                .tabItem {
                    Label("Özet", systemImage: "drop.fill")
                }
            
            // 2. Tarlalar Ekranı
            FieldsView()
                .tabItem { Label("Tarlalar", systemImage: "leaf.fill") }
            
            // 3. Asistan Ekrani
            AssistantView()
                .tabItem { Label("Asistan", systemImage: "mic.fill") }
            
            // 4. Analiz Ekranı (Kuantum Optimizasyon Sonuçları)
            OptimizationResultView()
                .tabItem {
                    Label("Analiz", systemImage: "chart.xyaxis.line")
                }
        }
        .tint(.blue) // DropWise temasına uygun su mavisi
    }
}

#Preview {
    ContentView()
}
