import '../models/club.dart';
import '../models/scout_report.dart';
import '../models/dashboard_stats.dart';
import '../core/api/reports_api.dart';
import '../core/api/dashboard_api.dart';
import '../core/api/players_api.dart';
import '../core/api/api_config.dart';

/// Data service with real API integration and mock data fallback
class DataService {
  final ReportsApi _reportsApi = ReportsApi();
  final DashboardApi _dashboardApi = DashboardApi();
  final PlayersApi _playersApi = PlayersApi();

  /// Get dashboard statistics
  Future<DashboardStats> getDashboardStats() async {
    try {
      return await _dashboardApi.getStats();
    } catch (e) {
      if (ApiConfig.useMockDataFallback) {
        return _getMockDashboardStats();
      }
      rethrow;
    }
  }

  /// Get scouts list (from API or mock)
  Future<List<Scout>> getScouts() async {
    // API doesn't have a direct scouts endpoint for clubs
    // Return mock data
    return _getMockScouts();
  }

  /// Get players list
  Future<List<Player>> getPlayers() async {
    try {
      final response = await _playersApi.getPlayers();
      return response.items;
    } catch (e) {
      if (ApiConfig.useMockDataFallback) {
        return _getMockPlayers();
      }
      rethrow;
    }
  }

  /// Get scout reports
  Future<List<ScoutReport>> getScoutReports({String? status}) async {
    try {
      final response = await _reportsApi.getReports(status: status);
      return response.items;
    } catch (e) {
      if (ApiConfig.useMockDataFallback) {
        return _getMockScoutReports();
      }
      rethrow;
    }
  }

  // ============ Mock Data Fallback Methods ============

  DashboardStats _getMockDashboardStats() {
    return const DashboardStats(
      totalPlayers: 156,
      activeScouts: 12,
      pendingReports: 8,
      approvedTransfers: 3,
      onlineScouts: 5,
      weeklyActivity: [12, 18, 15, 22, 19, 25, 20],
      apiResponseMs: 45,
      dbStatus: true,
    );
  }

  List<Scout> _getMockScouts() {
    return [
      Scout(
        id: 's1',
        name: 'Ahmet Yılmaz',
        email: 'ahmet@futveri.com',
        region: 'İstanbul',
        totalReports: 45,
        activeAssignments: 3,
        joinedAt: DateTime.now().subtract(const Duration(days: 180)),
        isActive: true,
      ),
      Scout(
        id: 's2',
        name: 'Mehmet Kaya',
        email: 'mehmet@futveri.com',
        region: 'Ankara',
        totalReports: 32,
        activeAssignments: 2,
        joinedAt: DateTime.now().subtract(const Duration(days: 120)),
        isActive: true,
      ),
      Scout(
        id: 's3',
        name: 'Ali Demir',
        email: 'ali@futveri.com',
        region: 'İzmir',
        totalReports: 28,
        activeAssignments: 4,
        joinedAt: DateTime.now().subtract(const Duration(days: 90)),
        isActive: true,
      ),
      Scout(
        id: 's4',
        name: 'Can Öztürk',
        email: 'can@futveri.com',
        region: 'Bursa',
        totalReports: 15,
        activeAssignments: 1,
        joinedAt: DateTime.now().subtract(const Duration(days: 60)),
        isActive: false,
      ),
      Scout(
        id: 's5',
        name: 'Emre Çelik',
        email: 'emre@futveri.com',
        region: 'Antalya',
        totalReports: 22,
        activeAssignments: 2,
        joinedAt: DateTime.now().subtract(const Duration(days: 150)),
        isActive: true,
      ),
    ];
  }

  List<Player> _getMockPlayers() {
    return const [
      Player(
        id: 'p1',
        name: 'Arda Güler',
        age: 18,
        position: 'Orta Saha',
        currentClub: 'Real Madrid',
        nationality: 'Türkiye',
        marketValue: 30000000,
        reportsCount: 5,
        averageRating: 8.5,
      ),
      Player(
        id: 'p2',
        name: 'Kerem Aktürkoğlu',
        age: 25,
        position: 'Sol Kanat',
        currentClub: 'Galatasaray',
        nationality: 'Türkiye',
        marketValue: 15000000,
        reportsCount: 3,
        averageRating: 7.8,
      ),
      Player(
        id: 'p3',
        name: 'Ferdi Kadıoğlu',
        age: 24,
        position: 'Sol Bek',
        currentClub: 'Brighton',
        nationality: 'Türkiye',
        marketValue: 25000000,
        reportsCount: 4,
        averageRating: 8.2,
      ),
      Player(
        id: 'p4',
        name: 'Baris Alper Yilmaz',
        age: 23,
        position: 'Sağ Kanat',
        currentClub: 'Galatasaray',
        nationality: 'Türkiye',
        marketValue: 12000000,
        reportsCount: 2,
        averageRating: 7.5,
      ),
      Player(
        id: 'p5',
        name: 'Orkun Kökçü',
        age: 23,
        position: 'Orta Saha',
        currentClub: 'Benfica',
        nationality: 'Türkiye',
        marketValue: 28000000,
        reportsCount: 6,
        averageRating: 8.0,
      ),
    ];
  }

  List<ScoutReport> _getMockScoutReports() {
    return [
      ScoutReport(
        id: 'r1',
        playerName: 'Arda Güler',
        scoutName: 'Ahmet Yılmaz',
        scoutId: 's1',
        playerAge: 18,
        position: 'Orta Saha',
        currentClub: 'Real Madrid',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: ReportStatus.pending,
        physical: const RatingDetails(value: 75, description: 'Fiziksel olarak iyi, dayanıklılık geliştirilmeli'),
        technical: const RatingDetails(value: 92, description: 'Üstün teknik kapasite, pas ve şut harika'),
        tactical: const RatingDetails(value: 85, description: 'Taktik zekası yüksek, pozisyon alma iyi'),
        mental: const RatingDetails(value: 88, description: 'Baskı altında sakin, liderlik potansiyeli var'),
        overall: const RatingDetails(value: 85, description: 'Dünya çapında potansiyel'),
        potential: const RatingDetails(value: 95, description: 'Ballon d\'Or adayı olabilir'),
        notes: 'Kesinlikle takip edilmeli, transfer için öncelikli hedef',
      ),
      ScoutReport(
        id: 'r2',
        playerName: 'Kerem Aktürkoğlu',
        scoutName: 'Mehmet Kaya',
        scoutId: 's2',
        playerAge: 25,
        position: 'Sol Kanat',
        currentClub: 'Galatasaray',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        status: ReportStatus.approved,
        physical: const RatingDetails(value: 82, description: 'Hızlı ve çevik'),
        technical: const RatingDetails(value: 78, description: 'Dribling çok iyi'),
        tactical: const RatingDetails(value: 72, description: 'Defansif katkı geliştirilebilir'),
        mental: const RatingDetails(value: 80, description: 'Maç kazandıran mentalite'),
        overall: const RatingDetails(value: 78, description: 'Süper Lig\'in en iyi kanatçılarından'),
        potential: const RatingDetails(value: 82, description: 'Avrupa\'da başarılı olabilir'),
      ),
      ScoutReport(
        id: 'r3',
        playerName: 'Ferdi Kadıoğlu',
        scoutName: 'Ali Demir',
        scoutId: 's3',
        playerAge: 24,
        position: 'Sol Bek',
        currentClub: 'Brighton',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        status: ReportStatus.pending,
        physical: const RatingDetails(value: 85, description: 'Atletik yapı, iyi koşu kapasitesi'),
        technical: const RatingDetails(value: 80, description: 'Pas kalitesi yüksek'),
        tactical: const RatingDetails(value: 82, description: 'Hem defans hem hücumda etkili'),
        mental: const RatingDetails(value: 84, description: 'Profesyonel yaklaşım'),
        overall: const RatingDetails(value: 82, description: 'Premier League kalitesinde'),
        potential: const RatingDetails(value: 85, description: 'Büyük kulüplerde oynayabilir'),
      ),
      ScoutReport(
        id: 'r4',
        playerName: 'Baris Alper Yilmaz',
        scoutName: 'Emre Çelik',
        scoutId: 's5',
        playerAge: 23,
        position: 'Sağ Kanat',
        currentClub: 'Galatasaray',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        status: ReportStatus.rejected,
        physical: const RatingDetails(value: 78, description: 'Hızlı ama fiziksel mücadelede zayıf'),
        technical: const RatingDetails(value: 75, description: 'Gelişime açık'),
        tactical: const RatingDetails(value: 70, description: 'Pozisyon alma zayıf'),
        mental: const RatingDetails(value: 72, description: 'Tutarsız performans'),
        overall: const RatingDetails(value: 74, description: 'Ortalama seviye'),
        potential: const RatingDetails(value: 78, description: 'Doğru eğitimle gelişebilir'),
        notes: 'Transfer için uygun değil, izlemeye devam',
      ),
      ScoutReport(
        id: 'r5',
        playerName: 'Orkun Kökçü',
        scoutName: 'Ahmet Yılmaz',
        scoutId: 's1',
        playerAge: 23,
        position: 'Orta Saha',
        currentClub: 'Benfica',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        status: ReportStatus.approved,
        physical: const RatingDetails(value: 80, description: 'Dayanıklı, iyi kondisyon'),
        technical: const RatingDetails(value: 86, description: 'Harika pas ve şut'),
        tactical: const RatingDetails(value: 84, description: 'Oyun okuma kabiliyeti yüksek'),
        mental: const RatingDetails(value: 85, description: 'Kaptan karakteri'),
        overall: const RatingDetails(value: 84, description: 'Avrupa\'nın dikkat çeken yeteneklerinden'),
        potential: const RatingDetails(value: 88, description: 'Top 5 lig kalitesi'),
      ),
    ];
  }
}

/// Singleton instance
final dataService = DataService();
