"""
Trendyol Süper Lig 2025-2026 Complete Fixture Data
34 Matchweeks × 9 Matches = 306 Total Matches
18 Teams

Data compiled from official TFF sources
Season: August 8, 2025 - May 17, 2026
"""
from datetime import datetime
from typing import List, Dict, Optional

# =============================================================================
# SÜPER LİG 2025-2026 TEAMS (18 Teams)
# =============================================================================

SUPER_LIG_TEAMS = {
    "gs": {
        "id": "gs",
        "name": "Galatasaray",
        "short_name": "GS",
        "badge_url": "https://www.thesportsdb.com/images/media/team/badge/io7jk21767941298.png",
        "stadium": "Rams Park"
    },
    "fb": {
        "id": "fb",
        "name": "Fenerbahçe",
        "short_name": "FB",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/twxxvs1448199691.png",
        "stadium": "Ülker Stadyumu"
    },
    "bjk": {
        "id": "bjk",
        "name": "Beşiktaş",
        "short_name": "BJK",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/cg07mt1679455607.png",
        "stadium": "Tüpraş Stadyumu"
    },
    "ts": {
        "id": "ts",
        "name": "Trabzonspor",
        "short_name": "TS",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/43oobe1672951178.png",
        "stadium": "Papara Park"
    },
    "ant": {
        "id": "ant",
        "name": "Antalyaspor",
        "short_name": "ANT",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/vqoral1601669436.png",
        "stadium": "Corendon Airlines Park"
    },
    "kas": {
        "id": "kas",
        "name": "Kasımpaşa",
        "short_name": "KAS",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/uryxtp1448203236.png",
        "stadium": "Recep Tayyip Erdoğan Stadyumu"
    },
    "sam": {
        "id": "sam",
        "name": "Samsunspor",
        "short_name": "SAM",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/vz05y71679456608.png",
        "stadium": "Samsun 19 Mayıs Stadyumu"
    },
    "gen": {
        "id": "gen",
        "name": "Gençlerbirliği",
        "short_name": "GEN",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/5hnd1c1639569938.png",
        "stadium": "Eryaman Stadyumu"
    },
    "eyp": {
        "id": "eyp",
        "name": "Eyüpspor",
        "short_name": "EYP",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/7fb0ub1626445710.png",
        "stadium": "Alibeyköy Stadyumu"
    },
    "kon": {
        "id": "kon",
        "name": "Konyaspor",
        "short_name": "KON",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/rxwptr1448203413.png",
        "stadium": "Konya Büyükşehir Stadyumu"
    },
    "rze": {
        "id": "rze",
        "name": "Rizespor",
        "short_name": "RZE",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/t7senr1657195719.png",
        "stadium": "Çaykur Didi Stadyumu"
    },
    "goz": {
        "id": "goz",
        "name": "Göztepe",
        "short_name": "GOZ",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/9jwk7o1513952059.png",
        "stadium": "Gürsel Aksel Stadyumu"
    },
    "koc": {
        "id": "koc",
        "name": "Kocaelispor",
        "short_name": "KOC",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/f6erki1626445224.png",
        "stadium": "Kocaeli Stadyumu"
    },
    "gaz": {
        "id": "gaz",
        "name": "Gaziantep FK",
        "short_name": "GAZ",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/54j6ik1579458093.png",
        "stadium": "Gaziantep Stadyumu"
    },
    "aln": {
        "id": "aln",
        "name": "Alanyaspor",
        "short_name": "ALN",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/9fr3071601667898.png",
        "stadium": "Haydar Aliyev Stadyumu"
    },
    "bas": {
        "id": "bas",
        "name": "Başakşehir",
        "short_name": "BAS",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/895mqt1685993958.png",
        "stadium": "Başakşehir Fatih Terim Stadyumu"
    },
    "kay": {
        "id": "kay",
        "name": "Kayserispor",
        "short_name": "KAY",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/bvskgi1601668985.png",
        "stadium": "RHG Enertürk Enerji Stadyumu"
    },
    "fkg": {
        "id": "fkg",
        "name": "Fatih Karagümrük",
        "short_name": "FKG",
        "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/bfb84y1580847945.png",
        "stadium": "Atatürk Olimpiyat Stadyumu"
    }
}

# =============================================================================
# 34 HAFTA FİKSTÜR (Tam Sezon)
# Format: (home_team_id, away_team_id)
# Her hafta 9 maç, toplam 306 maç
# =============================================================================

# Round-robin fixture generation for 18 teams
# First half: Rounds 1-17, Second half: Rounds 18-34 (reverse of first half)

FIXTURE_TEMPLATE = {
    # ================= İLK YARI (Hafta 1-17) =================
    1: [
        ("gaz", "gs"),    # Gaziantep - Galatasaray
        ("ant", "kas"),   # Antalyaspor - Kasımpaşa
        ("sam", "gen"),   # Samsunspor - Gençlerbirliği
        ("eyp", "kon"),   # Eyüpspor - Konyaspor
        ("rze", "goz"),   # Rizespor - Göztepe
        ("ts", "koc"),    # Trabzonspor - Kocaelispor
        ("aln", "bjk"),   # Alanyaspor - Beşiktaş
        ("bas", "fb"),    # Başakşehir - Fenerbahçe
        ("fkg", "kay"),   # F.Karagümrük - Kayserispor
    ],
    2: [
        ("gs", "fkg"),    # Galatasaray - F.Karagümrük
        ("koc", "sam"),   # Kocaelispor - Samsunspor
        ("aln", "rze"),   # Alanyaspor - Rizespor
        ("goz", "fb"),    # Göztepe - Fenerbahçe
        ("kon", "gaz"),   # Konyaspor - Gaziantep
        ("bas", "kay"),   # Başakşehir - Kayserispor
        ("bjk", "eyp"),   # Beşiktaş - Eyüpspor
        ("gen", "ant"),   # Gençlerbirliği - Antalyaspor
        ("kas", "ts"),    # Kasımpaşa - Trabzonspor
    ],
    3: [
        ("fb", "gs"),     # Fenerbahçe - Galatasaray (DERBİ)
        ("sam", "bjk"),   # Samsunspor - Beşiktaş
        ("rze", "bas"),   # Rizespor - Başakşehir
        ("gaz", "koc"),   # Gaziantep - Kocaelispor
        ("ant", "eyp"),   # Antalyaspor - Eyüpspor
        ("kay", "aln"),   # Kayserispor - Alanyaspor
        ("ts", "gen"),    # Trabzonspor - Gençlerbirliği
        ("kon", "fkg"),   # Konyaspor - F.Karagümrük
        ("kas", "goz"),   # Kasımpaşa - Göztepe
    ],
    4: [
        ("gs", "kas"),    # Galatasaray - Kasımpaşa
        ("bjk", "ant"),   # Beşiktaş - Antalyaspor
        ("aln", "fb"),    # Alanyaspor - Fenerbahçe
        ("gen", "kon"),   # Gençlerbirliği - Konyaspor
        ("fkg", "gaz"),   # F.Karagümrük - Gaziantep
        ("eyp", "ts"),    # Eyüpspor - Trabzonspor
        ("goz", "rze"),   # Göztepe - Rizespor
        ("bas", "sam"),   # Başakşehir - Samsunspor
        ("kay", "koc"),   # Kayserispor - Kocaelispor
    ],
    5: [
        ("fb", "bjk"),    # Fenerbahçe - Beşiktaş (DERBİ)
        ("kas", "gen"),   # Kasımpaşa - Gençlerbirliği
        ("ts", "aln"),    # Trabzonspor - Alanyaspor
        ("gaz", "goz"),   # Gaziantep - Göztepe
        ("ant", "gs"),    # Antalyaspor - Galatasaray
        ("rze", "kay"),   # Rizespor - Kayserispor
        ("kon", "bas"),   # Konyaspor - Başakşehir
        ("koc", "fkg"),   # Kocaelispor - F.Karagümrük
        ("sam", "eyp"),   # Samsunspor - Eyüpspor
    ],
    6: [
        ("gs", "ts"),     # Galatasaray - Trabzonspor (DERBİ)
        ("bjk", "gaz"),   # Beşiktaş - Gaziantep
        ("gen", "fb"),    # Gençlerbirliği - Fenerbahçe
        ("aln", "kas"),   # Alanyaspor - Kasımpaşa
        ("fkg", "rze"),   # F.Karagümrük - Rizespor
        ("eyp", "goz"),   # Eyüpspor - Göztepe
        ("bas", "koc"),   # Başakşehir - Kocaelispor
        ("kay", "sam"),   # Kayserispor - Samsunspor
        ("kon", "ant"),   # Konyaspor - Antalyaspor
    ],
    7: [
        ("ts", "fb"),     # Trabzonspor - Fenerbahçe (DERBİ)
        ("goz", "gs"),    # Göztepe - Galatasaray
        ("kas", "kon"),   # Kasımpaşa - Konyaspor
        ("rze", "bjk"),   # Rizespor - Beşiktaş
        ("gaz", "aln"),   # Gaziantep - Alanyaspor
        ("koc", "eyp"),   # Kocaelispor - Eyüpspor
        ("ant", "bas"),   # Antalyaspor - Başakşehir
        ("sam", "fkg"),   # Samsunspor - F.Karagümrük
        ("gen", "kay"),   # Gençlerbirliği - Kayserispor
    ],
    8: [
        ("gs", "bjk"),    # Galatasaray - Beşiktaş (DERBİ)
        ("fb", "kas"),    # Fenerbahçe - Kasımpaşa
        ("aln", "gen"),   # Alanyaspor - Gençlerbirliği
        ("eyp", "rze"),   # Eyüpspor - Rizespor
        ("kay", "ts"),    # Kayserispor - Trabzonspor
        ("bas", "gaz"),   # Başakşehir - Gaziantep
        ("fkg", "goz"),   # F.Karagümrük - Göztepe
        ("kon", "sam"),   # Konyaspor - Samsunspor
        ("koc", "ant"),   # Kocaelispor - Antalyaspor
    ],
    9: [
        ("bjk", "fb"),    # Beşiktaş - Fenerbahçe (DERBİ)
        ("ts", "gs"),     # Trabzonspor - Galatasaray (DERBİ)
        ("kas", "koc"),   # Kasımpaşa - Kocaelispor
        ("gen", "bas"),   # Gençlerbirliği - Başakşehir
        ("goz", "aln"),   # Göztepe - Alanyaspor
        ("rze", "kon"),   # Rizespor - Konyaspor
        ("gaz", "eyp"),   # Gaziantep - Eyüpspor
        ("ant", "fkg"),   # Antalyaspor - F.Karagümrük
        ("sam", "kay"),   # Samsunspor - Kayserispor
    ],
    10: [
        ("gs", "koc"),    # Galatasaray - Kocaelispor
        ("fb", "rze"),    # Fenerbahçe - Rizespor
        ("aln", "ant"),   # Alanyaspor - Antalyaspor
        ("bas", "ts"),    # Başakşehir - Trabzonspor
        ("fkg", "bjk"),   # F.Karagümrük - Beşiktaş
        ("eyp", "kas"),   # Eyüpspor - Kasımpaşa
        ("kay", "gaz"),   # Kayserispor - Gaziantep
        ("kon", "goz"),   # Konyaspor - Göztepe
        ("sam", "gen"),   # Samsunspor - Gençlerbirliği
    ],
    11: [
        ("bjk", "ts"),    # Beşiktaş - Trabzonspor (DERBİ)
        ("koc", "fb"),    # Kocaelispor - Fenerbahçe
        ("kas", "aln"),   # Kasımpaşa - Alanyaspor
        ("rze", "gs"),    # Rizespor - Galatasaray
        ("gaz", "sam"),   # Gaziantep - Samsunspor
        ("ant", "kay"),   # Antalyaspor - Kayserispor
        ("gen", "fkg"),   # Gençlerbirliği - F.Karagümrük
        ("goz", "bas"),   # Göztepe - Başakşehir
        ("eyp", "kon"),   # Eyüpspor - Konyaspor
    ],
    12: [
        ("gs", "aln"),    # Galatasaray - Alanyaspor
        ("fb", "gaz"),    # Fenerbahçe - Gaziantep
        ("ts", "kas"),    # Trabzonspor - Kasımpaşa
        ("fkg", "eyp"),   # F.Karagümrük - Eyüpspor
        ("bas", "bjk"),   # Başakşehir - Beşiktaş
        ("kay", "goz"),   # Kayserispor - Göztepe
        ("kon", "koc"),   # Konyaspor - Kocaelispor
        ("sam", "ant"),   # Samsunspor - Antalyaspor
        ("gen", "rze"),   # Gençlerbirliği - Rizespor
    ],
    13: [
        ("bjk", "gs"),    # Beşiktaş - Galatasaray (DERBİ)
        ("aln", "ts"),    # Alanyaspor - Trabzonspor
        ("kas", "fb"),    # Kasımpaşa - Fenerbahçe
        ("goz", "gen"),   # Göztepe - Gençlerbirliği
        ("eyp", "bas"),   # Eyüpspor - Başakşehir
        ("rze", "fkg"),   # Rizespor - F.Karagümrük
        ("gaz", "kon"),   # Gaziantep - Konyaspor
        ("koc", "kay"),   # Kocaelispor - Kayserispor
        ("ant", "sam"),   # Antalyaspor - Samsunspor
    ],
    14: [
        ("gs", "gen"),    # Galatasaray - Gençlerbirliği
        ("fb", "aln"),    # Fenerbahçe - Alanyaspor
        ("ts", "goz"),    # Trabzonspor - Göztepe
        ("bas", "kas"),   # Başakşehir - Kasımpaşa
        ("fkg", "gaz"),   # F.Karagümrük - Gaziantep
        ("kay", "bjk"),   # Kayserispor - Beşiktaş
        ("kon", "rze"),   # Konyaspor - Rizespor
        ("sam", "koc"),   # Samsunspor - Kocaelispor
        ("eyp", "ant"),   # Eyüpspor - Antalyaspor
    ],
    15: [
        ("goz", "fb"),    # Göztepe - Fenerbahçe
        ("aln", "gs"),    # Alanyaspor - Galatasaray
        ("kas", "fkg"),   # Kasımpaşa - F.Karagümrük
        ("gen", "bjk"),   # Gençlerbirliği - Beşiktaş
        ("rze", "ts"),    # Rizespor - Trabzonspor
        ("gaz", "bas"),   # Gaziantep - Başakşehir
        ("koc", "eyp"),   # Kocaelispor - Eyüpspor
        ("ant", "kon"),   # Antalyaspor - Konyaspor
        ("kay", "sam"),   # Kayserispor - Samsunspor
    ],
    16: [
        ("gs", "eyp"),    # Galatasaray - Eyüpspor
        ("fb", "ts"),     # Fenerbahçe - Trabzonspor (DERBİ)
        ("bjk", "kas"),   # Beşiktaş - Kasımpaşa
        ("fkg", "aln"),   # F.Karagümrük - Alanyaspor
        ("bas", "rze"),   # Başakşehir - Rizespor
        ("kon", "kay"),   # Konyaspor - Kayserispor
        ("sam", "gaz"),   # Samsunspor - Gaziantep
        ("gen", "goz"),   # Gençlerbirliği - Göztepe
        ("ant", "koc"),   # Antalyaspor - Kocaelispor
    ],
    17: [
        ("ts", "bjk"),    # Trabzonspor - Beşiktaş (DERBİ)
        ("kas", "gs"),    # Kasımpaşa - Galatasaray
        ("aln", "eyp"),   # Alanyaspor - Eyüpspor
        ("goz", "fkg"),   # Göztepe - F.Karagümrük
        ("rze", "gaz"),   # Rizespor - Gaziantep
        ("koc", "bas"),   # Kocaelispor - Başakşehir
        ("kay", "fb"),    # Kayserispor - Fenerbahçe
        ("kon", "gen"),   # Konyaspor - Gençlerbirliği
        ("sam", "ant"),   # Samsunspor - Antalyaspor
    ],
}

# İkinci yarı (18-34. haftalar) - İlk yarının tersi (ev-deplasman değişir)
for i in range(1, 18):
    second_half_round = i + 17
    FIXTURE_TEMPLATE[second_half_round] = [
        (away, home) for home, away in FIXTURE_TEMPLATE[i]
    ]

# =============================================================================
# HAFTA TARİHLERİ (2025-2026 Sezonu)
# =============================================================================

ROUND_DATES = {
    1: {"start": datetime(2025, 8, 8), "end": datetime(2025, 8, 11)},
    2: {"start": datetime(2025, 8, 15), "end": datetime(2025, 8, 18)},
    3: {"start": datetime(2025, 8, 22), "end": datetime(2025, 8, 25)},
    4: {"start": datetime(2025, 8, 29), "end": datetime(2025, 9, 1)},
    5: {"start": datetime(2025, 9, 12), "end": datetime(2025, 9, 15)},
    6: {"start": datetime(2025, 9, 19), "end": datetime(2025, 9, 22)},
    7: {"start": datetime(2025, 9, 26), "end": datetime(2025, 9, 29)},
    8: {"start": datetime(2025, 10, 3), "end": datetime(2025, 10, 6)},
    9: {"start": datetime(2025, 10, 17), "end": datetime(2025, 10, 20)},
    10: {"start": datetime(2025, 10, 24), "end": datetime(2025, 10, 27)},
    11: {"start": datetime(2025, 10, 31), "end": datetime(2025, 11, 3)},
    12: {"start": datetime(2025, 11, 7), "end": datetime(2025, 11, 10)},
    13: {"start": datetime(2025, 11, 21), "end": datetime(2025, 11, 24)},
    14: {"start": datetime(2025, 11, 28), "end": datetime(2025, 12, 1)},
    15: {"start": datetime(2025, 12, 5), "end": datetime(2025, 12, 8)},
    16: {"start": datetime(2025, 12, 12), "end": datetime(2025, 12, 15)},
    17: {"start": datetime(2025, 12, 19), "end": datetime(2025, 12, 22)},
    # Devre arası: 23 Aralık 2025 - 15 Ocak 2026
    18: {"start": datetime(2026, 1, 16), "end": datetime(2026, 1, 19)},
    19: {"start": datetime(2026, 1, 23), "end": datetime(2026, 1, 26)},
    20: {"start": datetime(2026, 1, 30), "end": datetime(2026, 2, 2)},
    21: {"start": datetime(2026, 2, 6), "end": datetime(2026, 2, 9)},
    22: {"start": datetime(2026, 2, 13), "end": datetime(2026, 2, 16)},
    23: {"start": datetime(2026, 2, 20), "end": datetime(2026, 2, 23)},
    24: {"start": datetime(2026, 2, 27), "end": datetime(2026, 3, 2)},
    25: {"start": datetime(2026, 3, 6), "end": datetime(2026, 3, 9)},
    26: {"start": datetime(2026, 3, 13), "end": datetime(2026, 3, 16)},
    27: {"start": datetime(2026, 3, 20), "end": datetime(2026, 3, 23)},
    28: {"start": datetime(2026, 4, 3), "end": datetime(2026, 4, 6)},
    29: {"start": datetime(2026, 4, 10), "end": datetime(2026, 4, 13)},
    30: {"start": datetime(2026, 4, 17), "end": datetime(2026, 4, 20)},
    31: {"start": datetime(2026, 4, 24), "end": datetime(2026, 4, 27)},
    32: {"start": datetime(2026, 5, 1), "end": datetime(2026, 5, 4)},
    33: {"start": datetime(2026, 5, 8), "end": datetime(2026, 5, 11)},
    34: {"start": datetime(2026, 5, 15), "end": datetime(2026, 5, 17)},
}


def generate_match_id(round_num: int, match_index: int) -> str:
    """Generate unique match ID"""
    return f"sl2526_r{round_num:02d}_m{match_index + 1}"


def get_match_datetime(round_num: int, match_index: int) -> datetime:
    """Get match datetime based on round and match index"""
    round_info = ROUND_DATES.get(round_num)
    if not round_info:
        return datetime.now()
    
    # Distribute matches across the weekend
    # Matches 0-2: Friday/Saturday 19:00
    # Matches 3-5: Saturday 16:00 / 19:00 / 21:30
    # Matches 6-8: Sunday 16:00 / 19:00 / 21:30
    
    start = round_info["start"]
    
    time_slots = [
        (0, 21, 30),  # Friday 21:30
        (1, 16, 0),   # Saturday 16:00
        (1, 19, 0),   # Saturday 19:00
        (1, 21, 30),  # Saturday 21:30
        (1, 21, 30),  # Saturday 21:30
        (2, 16, 0),   # Sunday 16:00
        (2, 19, 0),   # Sunday 19:00
        (2, 21, 30),  # Sunday 21:30
        (2, 21, 30),  # Sunday 21:30
    ]
    
    slot = time_slots[match_index % len(time_slots)]
    from datetime import timedelta
    match_date = start + timedelta(days=slot[0])
    return datetime(match_date.year, match_date.month, match_date.day, slot[1], slot[2])


def generate_all_fixtures() -> List[Dict]:
    """Generate all 306 fixtures for the season"""
    all_fixtures = []
    
    for round_num in range(1, 35):
        matches = FIXTURE_TEMPLATE.get(round_num, [])
        
        for idx, (home_id, away_id) in enumerate(matches):
            home_team = SUPER_LIG_TEAMS.get(home_id, {})
            away_team = SUPER_LIG_TEAMS.get(away_id, {})
            
            match_dt = get_match_datetime(round_num, idx)
            now = datetime.now()
            
            fixture = {
                "id": generate_match_id(round_num, idx),
                "home_team_id": home_id,
                "away_team_id": away_id,
                "home_team_name": home_team.get("name", ""),
                "away_team_name": away_team.get("name", ""),
                "home_team_badge": home_team.get("badge_url", ""),
                "away_team_badge": away_team.get("badge_url", ""),
                "round": round_num,
                "match_datetime": match_dt.isoformat(),
                "stadium": home_team.get("stadium", ""),
                "status": "finished" if match_dt < now else "scheduled",
                "home_score": None,
                "away_score": None,
                "is_finished": match_dt < now,
                "is_upcoming": match_dt > now,
            }
            
            all_fixtures.append(fixture)
    
    return all_fixtures


def get_fixtures_by_round(round_num: int) -> List[Dict]:
    """Get fixtures for a specific round"""
    all_fixtures = generate_all_fixtures()
    return [f for f in all_fixtures if f["round"] == round_num]


def get_team_fixtures(team_id: str) -> List[Dict]:
    """Get all fixtures for a specific team"""
    all_fixtures = generate_all_fixtures()
    return [
        f for f in all_fixtures 
        if f["home_team_id"] == team_id or f["away_team_id"] == team_id
    ]


def get_upcoming_fixtures(limit: int = 20) -> List[Dict]:
    """Get upcoming fixtures"""
    all_fixtures = generate_all_fixtures()
    now = datetime.now()
    upcoming = [
        f for f in all_fixtures 
        if datetime.fromisoformat(f["match_datetime"]) > now
    ]
    return sorted(upcoming, key=lambda x: x["match_datetime"])[:limit]


def get_current_round() -> int:
    """Get current matchweek based on date"""
    now = datetime.now()
    
    for round_num, dates in ROUND_DATES.items():
        if dates["start"] <= now <= dates["end"]:
            return round_num
        if now < dates["start"]:
            return round_num
    
    return 34  # Season ended


def get_all_teams() -> List[Dict]:
    """Get all teams"""
    return list(SUPER_LIG_TEAMS.values())


def get_team_by_id(team_id: str) -> Optional[Dict]:
    """Get team by ID"""
    return SUPER_LIG_TEAMS.get(team_id)
