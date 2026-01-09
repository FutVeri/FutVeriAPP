# Backend Simulation API - Geliştirme Raporu

**Tarih:** 9 Ocak 2026  
**Oturum:** Backend Süper Lig Simulation API Geliştirmesi

---

## 📋 Özet

Bu oturumda `futveri_backend` için tam kapsamlı bir **Süper Lig 2025-2026 Simulation API** geliştirildi:

| Metrik | Değer |
|--------|-------|
| Toplam Takım | 18 |
| Toplam Oyuncu | 419 |
| Toplam Maç (Fikstür) | 306 (34 hafta × 9 maç) |
| Yeni Endpoint Sayısı | 15+ |

---

## 🗂️ Oluşturulan Dosyalar

### Data Layer
| Dosya | Açıklama |
|-------|----------|
| [super_lig_fixtures.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/data/super_lig_fixtures.py) | 34 haftalık fikstür + 18 takım bilgisi |
| [super_lig_teams_players.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/data/super_lig_teams_players.py) | Big 4 kadrolar (GS, FB, BJK, TS) |
| [super_lig_anadolu_teams.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/data/super_lig_anadolu_teams.py) | Anadolu takımları Part 1 (7 takım) |
| [super_lig_anadolu_teams_part2.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/data/super_lig_anadolu_teams_part2.py) | Anadolu takımları Part 2 (7 takım) |

### Schema Layer
| Dosya | Açıklama |
|-------|----------|
| [fixtures.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/schemas/fixtures.py) | Fikstür Pydantic modelleri |
| [teams_players.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/schemas/teams_players.py) | Takım/Oyuncu Pydantic modelleri |

### API Layer
| Dosya | Açıklama |
|-------|----------|
| [fixtures.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/api/v1/fixtures.py) | Fikstür endpoint'leri |
| [simulation.py](file:///Users/ertu/Desktop/FutVeriAPP/futveri_backend/app/api/v1/simulation.py) | Takım/Oyuncu/Matchup endpoint'leri |

---

## 🔌 API Endpoints

### Fixtures API (`/api/v1/fixtures/`)

```
GET /api/v1/fixtures/                    # Tüm maçlar
GET /api/v1/fixtures/?round=5            # 5. hafta maçları
GET /api/v1/fixtures/?team_id=gs         # Galatasaray maçları
GET /api/v1/fixtures/round/{num}         # Belirli hafta (1-34)
GET /api/v1/fixtures/upcoming            # Yaklaşan maçlar
GET /api/v1/fixtures/current-round       # Mevcut hafta
GET /api/v1/fixtures/team/{team_id}      # Takım fikstürü
GET /api/v1/fixtures/teams               # Tüm takımlar (basit)
GET /api/v1/fixtures/season              # Sezon özeti
GET /api/v1/fixtures/match/{match_id}    # Tek maç detayı
```

### Simulation API (`/api/v1/simulation/`)

```
GET /api/v1/simulation/teams                      # Tüm takımlar
GET /api/v1/simulation/teams?category=big4        # Sadece Big 4
GET /api/v1/simulation/teams?category=anadolu     # Sadece Anadolu
GET /api/v1/simulation/teams/{team_id}            # Takım + oyuncular
GET /api/v1/simulation/teams/{team_id}/strength   # Takım güç analizi
GET /api/v1/simulation/teams/{team_id}/key-players # Kilit oyuncular
GET /api/v1/simulation/players                    # Tüm oyuncular
GET /api/v1/simulation/players?position=ST        # Pozisyona göre
GET /api/v1/simulation/players?min_overall=80     # Rating filtresi
GET /api/v1/simulation/players/{player_id}        # Oyuncu detayı
GET /api/v1/simulation/matchup/{home}/{away}      # Maç önizlemesi + tahmin
```

---

## 📱 Mobile Entegrasyon Rehberi

### 1. API Servisi Oluşturma (Dart)

```dart
// lib/core/services/simulation_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class SimulationApiService {
  final String baseUrl;
  
  SimulationApiService({required this.baseUrl});
  
  // Tüm takımları getir
  Future<List<Team>> getAllTeams({String? category}) async {
    final uri = Uri.parse('$baseUrl/api/v1/simulation/teams')
        .replace(queryParameters: category != null ? {'category': category} : null);
    
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    
    return (data['teams'] as List)
        .map((t) => Team.fromJson(t))
        .toList();
  }
  
  // Takım detayı + oyuncular
  Future<TeamWithPlayers> getTeamDetails(String teamId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/simulation/teams/$teamId'),
    );
    final data = jsonDecode(response.body);
    return TeamWithPlayers.fromJson(data['team']);
  }
  
  // Maç önizlemesi
  Future<MatchupPreview> getMatchupPreview(String homeId, String awayId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/simulation/matchup/$homeId/$awayId'),
    );
    final data = jsonDecode(response.body);
    return MatchupPreview.fromJson(data['matchup']);
  }
  
  // Haftalık fikstür
  Future<List<Fixture>> getFixturesByRound(int round) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/fixtures/round/$round'),
    );
    final data = jsonDecode(response.body);
    return (data['fixtures'] as List)
        .map((f) => Fixture.fromJson(f))
        .toList();
  }
}
```

### 2. Model Sınıfları (Dart)

```dart
// lib/features/simulation/data/models/team_model.dart

class Team {
  final String id;
  final String name;
  final String shortName;
  final String badgeUrl;
  final String stadium;
  final int overallRating;
  final int attackRating;
  final int midfieldRating;
  final int defenseRating;
  final List<String> form;
  
  Team.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    name = json['name'],
    shortName = json['short_name'],
    badgeUrl = json['badge_url'],
    stadium = json['stadium'],
    overallRating = json['overall_rating'],
    attackRating = json['attack_rating'],
    midfieldRating = json['midfield_rating'],
    defenseRating = json['defense_rating'],
    form = List<String>.from(json['form'] ?? []);
}

class Player {
  final String id;
  final String name;
  final String position;
  final int number;
  final String nationality;
  final int age;
  final int overall;
  final PlayerAttributes attributes;
  final bool isKeyPlayer;
  final double marketValue;
  
  Player.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    position = json['position'],
    number = json['number'],
    nationality = json['nationality'],
    age = json['age'],
    overall = json['overall'],
    attributes = PlayerAttributes.fromJson(json['attributes']),
    isKeyPlayer = json['is_key_player'] ?? false,
    marketValue = (json['market_value'] ?? 0).toDouble();
}

class PlayerAttributes {
  final int pace;
  final int stamina;
  final int strength;
  final int shooting;
  final int passing;
  final int dribbling;
  final int defending;
  final int vision;
  final int composure;
  final int reflexes;
  final int positioningGk;
  
  PlayerAttributes.fromJson(Map<String, dynamic> json) :
    pace = json['pace'],
    stamina = json['stamina'],
    strength = json['strength'],
    shooting = json['shooting'],
    passing = json['passing'],
    dribbling = json['dribbling'],
    defending = json['defending'],
    vision = json['vision'],
    composure = json['composure'],
    reflexes = json['reflexes'] ?? 0,
    positioningGk = json['positioning_gk'] ?? 0;
}
```

### 3. Provider/Repository Pattern

```dart
// lib/features/simulation/data/repositories/simulation_repository.dart

class SimulationRepository {
  final SimulationApiService _api;
  
  SimulationRepository(this._api);
  
  // Cache
  List<Team>? _cachedTeams;
  
  Future<List<Team>> getTeams({bool forceRefresh = false}) async {
    if (_cachedTeams != null && !forceRefresh) {
      return _cachedTeams!;
    }
    _cachedTeams = await _api.getAllTeams();
    return _cachedTeams!;
  }
  
  Future<TeamWithPlayers> getTeamWithPlayers(String teamId) async {
    return _api.getTeamDetails(teamId);
  }
  
  Future<MatchupPreview> getMatchPreview(String homeId, String awayId) async {
    return _api.getMatchupPreview(homeId, awayId);
  }
}
```

### 4. UI'da Kullanım Örneği

```dart
// Takım seçim sayfasında
class TeamSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Team>>(
      future: context.read<SimulationRepository>().getTeams(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        
        final teams = snapshot.data!;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: teams.length,
          itemBuilder: (context, index) {
            final team = teams[index];
            return TeamCard(
              team: team,
              onTap: () => _selectTeam(context, team),
            );
          },
        );
      },
    );
  }
}

// Maç simülasyonu başlatmadan önce
void startSimulation(String homeId, String awayId) async {
  final preview = await repository.getMatchPreview(homeId, awayId);
  
  // Tahmin olasılıklarını göster
  print('Ev sahibi kazanma: ${preview.prediction.homeWin}%');
  print('Beraberlik: ${preview.prediction.draw}%');
  print('Deplasman kazanma: ${preview.prediction.awayWin}%');
  
  // Kilit oyuncuları kullan
  setupKeyPlayers(preview.homeKeyPlayers, preview.awayKeyPlayers);
}
```

---

## 📊 Veri Yapıları

### Takım ID'leri
```
Big 4:     gs, fb, bjk, ts
Anadolu:   ant, kas, sam, gen, eyp, kon, rze, goz, koc, gaz, aln, bas, kay, fkg
```

### Oyuncu Pozisyonları
```
GK  - Kaleci
CB  - Stoper
RB  - Sağ Bek
LB  - Sol Bek
CDM - Defansif Orta Saha
CM  - Orta Saha
CAM - Ofansif Orta Saha
RM  - Sağ Kanat (Orta Saha)
LM  - Sol Kanat (Orta Saha)
RW  - Sağ Kanat
LW  - Sol Kanat
ST  - Santrfor
CF  - Yardımcı Forvet
```

### Örnek API Response

```json
// GET /api/v1/simulation/teams/gs
{
  "success": true,
  "team": {
    "id": "gs",
    "name": "Galatasaray",
    "short_name": "GS",
    "badge_url": "https://...",
    "stadium": "Rams Park",
    "overall_rating": 85,
    "attack_rating": 88,
    "midfield_rating": 84,
    "defense_rating": 82,
    "form": ["W", "W", "D", "W", "W"],
    "players": [
      {
        "id": "gs_45",
        "name": "Victor Osimhen",
        "position": "ST",
        "number": 45,
        "nationality": "Nigeria",
        "age": 26,
        "overall": 90,
        "attributes": {
          "pace": 90,
          "shooting": 88,
          "passing": 65,
          "dribbling": 82,
          "defending": 35,
          "physical": 85
        },
        "is_key_player": true,
        "market_value": 120.0
      }
      // ... diğer oyuncular
    ]
  }
}
```

---

## 🚀 Backend'i Çalıştırma

```bash
cd futveri_backend
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

API Docs: `http://localhost:8000/docs`

---

## ✅ Sonraki Adımlar

1. **Mobile:** API servisini oluştur ve model sınıflarını ekle
2. **Mobile:** Mevcut mock data yerine API'den veri çek
3. **Mobile:** Takım/oyuncu seçim UI'larını güncelle
4. **Backend:** Gerçek maç sonuçlarını güncellemek için admin endpoint ekle
5. **Backend:** Oyuncu istatistiklerini canlı verilerle güncelle

---

*Rapor oluşturma tarihi: 9 Ocak 2026*
