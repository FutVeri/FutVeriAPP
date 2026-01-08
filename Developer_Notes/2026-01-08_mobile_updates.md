# Developer Notes - 08.01.2026

Bugün mobil uygulama (`futveri`) üzerinde Lig Sistemi, Üye Detayları ve interaktif Maç Simülasyonu üzerine yoğunlaşıldı.

## 1. Lig Sistemi ve Rozet Entegrasyonu (League System)
- **Veri Modeli**: `League`, `LeagueMember` ve `LeagueBadge` modelleri oluşturuldu.
- **Liderlik Tablosu**: `LeaderboardPage` tamamen yenilendi. 30 kişilik lig yapısı, kalan süre sayacı ve ilk 3 için özel kürsü (podium) görünümü eklendi.
- **Rozetler**: `LeagueBadgeType` enum'ı ile Altın, Gümüş ve Bronz rozetleri tanımlandı. Üyelerin kazandığı rozetlerin ikonik gösterimi (🥇, 🥈, 🥉) sağlandı.
- **Profil Entegrasyonu**: Kullanıcının kazandığı rozetler `ProfilePage` üzerinde üst bölümde sergilenmeye başlandı.

## 2. Üye Detay Ekranı
- Liderlik tablosundaki herhangi bir üyeye tıklandığında açılan modern bir **Modal Bottom Sheet** (`_showMemberDetail`) eklendi.
- Detay ekranında üyenin rütbesi, toplam puanı, rapor sayısı ve geçmiş başarılarını temsil eden rozetler şık bir UI ile gösterildi.

## 3. FutVeri 2D Maç Simülasyonu (FM Style)
FM tarzı interaktif bir simülasyon deneyimi sıfırdan geliştirildi:
- **Simülasyon Motoru (`MatchEngine`)**: 1 saniyenin 1 dakikaya denk geldiği, gerçek zamanlı bir motor yazıldı. Gol, şut, faul, kart gibi olaylar ve rastgele oyuncu hareketleri simüle ediliyor.
- **Maç Seçimi (`SimulationPage`)**: Haftalık fikstürden istenilen maçı seçme arayüzü eklendi.
- **Teknik Direktör Seçimi (`TeamSelectionPage`)**: Kullanıcının simülasyonda hangi takımı yönetmek istediğini seçtiği ekran.
- **2D Saha (`MatchSimulationScreen`)**: Oyuncuların topun konumuna göre hareket ettiği, skor ve canlı maç loglarının aktığı interaktif 2D saha görünümü.
- **Taktik Müdahale (`TacticalInterventionDashboard`)**: Maçı durdurup (Pause) mantalite (Hücum, Defans, Dengeli) ve formasyon değişikliği yapabilme özelliği.
- **AI Coach Placeholder**: Gelecekte eklenecek olan LLM tabanlı taktik önerileri için altyapı hazırlandı.

## 4. UI/UX ve Navigasyon
- Bottom Navigation Bar üzerindeki orta butonun ikonu `gamepad2` olarak güncellendi ve doğrudan simülasyon modülüne bağlandı.
- Uygulama rotaları (`app_router.dart`) yeni simülasyon ekranlarını destekleyecek şekilde genişletildi.

---
**Not**: Tüm sistem şu an mock data ile çalışmaktadır. `supabase_data_service.dart` içerisinde lig ve maç verileri için gerekli metodlar yorum satırı olarak hazır bekletilmektedir.
