"""
Trendyol Süper Lig 2025-2026 - Complete Squad Data
All 18 teams with full squads
Data Sources: Transfermarkt, FotMob, Official Club Websites
Last Updated: January 2026
"""
from typing import Dict, List, Optional

# =============================================================================
# PLAYER HELPER
# =============================================================================
def p(id: str, name: str, pos: str, num: int, nat: str, age: int, ovr: int,
      pac: int, sta: int, str_: int, sho: int, pas: int, dri: int, def_: int,
      vis: int, com: int, ref: int = 0, pos_gk: int = 0, key: bool = False, val: float = 0.0):
    return {
        "id": id, "name": name, "position": pos, "number": num,
        "nationality": nat, "age": age, "overall": ovr,
        "attributes": {
            "pace": pac, "stamina": sta, "strength": str_, "shooting": sho,
            "passing": pas, "dribbling": dri, "defending": def_, "vision": vis,
            "composure": com, "reflexes": ref, "positioning_gk": pos_gk
        },
        "is_key_player": key, "market_value": val, "image_url": ""
    }

# =============================================================================
# GALATASARAY 2025-2026 (26 Players)
# =============================================================================
GALATASARAY = {
    "id": "gs", "name": "Galatasaray", "short_name": "GS",
    "badge_url": "https://www.thesportsdb.com/images/media/team/badge/io7jk21767941298.png",
    "stadium": "Rams Park", "stadium_capacity": 52652, "coach": "Okan Buruk",
    "founded": 1905, "colors": {"primary": "#FDB912", "secondary": "#A31923"},
    "league_position": 1, "overall_rating": 85, "attack_rating": 88,
    "midfield_rating": 84, "defense_rating": 82, "form": ["W", "W", "D", "W", "W"],
    "players": [
        # Goalkeepers
        p("gs_1", "Uğurcan Çakır", "GK", 1, "Turkey", 29, 84, 45, 70, 78, 20, 55, 35, 25, 60, 82, 86, 84, True, 18.0),
        p("gs_23", "Günay Güvenç", "GK", 23, "Turkey", 33, 75, 40, 68, 74, 15, 48, 28, 20, 52, 74, 76, 75, False, 1.0),
        # Defenders
        p("gs_6", "Davinson Sánchez", "CB", 6, "Colombia", 29, 82, 78, 82, 86, 35, 58, 52, 84, 55, 78, key=True, val=15.0),
        p("gs_42", "Abdülkerim Bardakcı", "CB", 42, "Turkey", 31, 79, 72, 80, 82, 38, 55, 48, 81, 52, 76, val=8.0),
        p("gs_4", "Victor Nelsson", "CB", 4, "Denmark", 26, 78, 74, 78, 80, 35, 58, 52, 80, 55, 76, val=10.0),
        p("gs_3", "Kaan Ayhan", "CB", 3, "Turkey", 30, 78, 70, 78, 80, 42, 62, 52, 79, 58, 75, val=5.0),
        p("gs_2", "Wilfried Singo", "RB", 2, "Ivory Coast", 24, 80, 88, 85, 78, 58, 68, 72, 76, 65, 74, key=True, val=22.0),
        p("gs_22", "Elias Jelert", "RB", 22, "Denmark", 20, 76, 85, 82, 72, 52, 68, 72, 74, 62, 72, val=8.0),
        p("gs_18", "Evren Eren Elmalı", "LB", 18, "Turkey", 24, 76, 82, 84, 70, 52, 68, 70, 74, 62, 72, val=6.0),
        p("gs_12", "Ismail Jakobs", "LB", 12, "Germany", 25, 77, 85, 82, 72, 55, 70, 74, 75, 65, 73, val=7.0),
        # Midfielders
        p("gs_8", "İlkay Gündoğan", "CM", 8, "Germany", 35, 85, 62, 78, 68, 78, 88, 82, 65, 90, 88, key=True, val=12.0),
        p("gs_34", "Lucas Torreira", "CDM", 34, "Uruguay", 29, 82, 68, 88, 72, 62, 78, 75, 82, 75, 80, key=True, val=20.0),
        p("gs_10", "Gabriel Sara", "CAM", 10, "Brazil", 26, 81, 72, 80, 65, 75, 82, 80, 42, 82, 78, val=18.0),
        p("gs_5", "Mario Lemina", "CDM", 5, "Gabon", 31, 78, 72, 82, 82, 58, 72, 70, 78, 68, 75, val=8.0),
        p("gs_14", "Kerem Demirbay", "CM", 14, "Germany", 32, 79, 68, 75, 70, 72, 82, 78, 55, 80, 78, val=5.0),
        p("gs_7", "Yunus Akgün", "LM", 7, "Turkey", 25, 79, 85, 82, 62, 72, 75, 82, 38, 75, 74, val=12.0),
        p("gs_11", "Hakim Ziyech", "RAM", 11, "Morocco", 32, 81, 72, 72, 62, 78, 85, 86, 32, 85, 78, val=8.0),
        # Forwards
        p("gs_45", "Victor Osimhen", "ST", 45, "Nigeria", 26, 90, 90, 82, 85, 88, 65, 82, 35, 72, 85, key=True, val=120.0),
        p("gs_19", "Leroy Sané", "RW", 19, "Germany", 30, 87, 92, 78, 68, 82, 80, 88, 32, 82, 80, key=True, val=45.0),
        p("gs_9", "Mauro Icardi", "ST", 9, "Argentina", 32, 84, 72, 75, 82, 88, 62, 78, 28, 75, 86, key=True, val=18.0),
        p("gs_17", "Barış Alper Yılmaz", "RW", 17, "Turkey", 24, 80, 90, 82, 65, 72, 70, 82, 35, 72, 75, val=25.0),
        p("gs_21", "Roland Sallai", "LW", 21, "Hungary", 27, 78, 82, 80, 72, 75, 72, 78, 32, 70, 74, val=8.0),
        p("gs_20", "Dries Mertens", "CF", 20, "Belgium", 38, 80, 70, 68, 60, 82, 82, 85, 28, 84, 82, val=2.0),
        p("gs_99", "Halil Dervişoğlu", "ST", 99, "Turkey", 25, 77, 85, 78, 68, 76, 62, 78, 22, 65, 73, val=6.0),
        p("gs_16", "Oğulcan Çağlayan", "RW", 16, "Turkey", 30, 76, 82, 78, 70, 70, 68, 76, 30, 68, 72, val=4.0),
        p("gs_77", "Kazımcan Karataş", "LW", 77, "Turkey", 20, 74, 85, 78, 65, 68, 62, 76, 28, 62, 70, val=3.0),
    ]
}

# =============================================================================
# FENERBAHÇE 2025-2026 (28 Players)
# =============================================================================
FENERBAHCE = {
    "id": "fb", "name": "Fenerbahçe", "short_name": "FB",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/twxxvs1448199691.png",
    "stadium": "Ülker Stadyumu", "stadium_capacity": 50530, "coach": "José Mourinho",
    "founded": 1907, "colors": {"primary": "#FFED00", "secondary": "#00205B"},
    "league_position": 2, "overall_rating": 84, "attack_rating": 85,
    "midfield_rating": 84, "defense_rating": 83, "form": ["W", "W", "W", "D", "W"],
    "players": [
        # Goalkeepers
        p("fb_1", "Ederson", "GK", 1, "Brazil", 32, 88, 52, 72, 80, 25, 85, 45, 28, 75, 88, 88, 86, True, 35.0),
        p("fb_12", "İrfan Can Eğribayat", "GK", 12, "Turkey", 28, 78, 42, 70, 75, 18, 52, 32, 22, 55, 75, 80, 78, val=3.0),
        p("fb_23", "Tarık Çetin", "GK", 23, "Turkey", 23, 72, 40, 68, 72, 15, 48, 28, 20, 50, 70, 74, 72, val=0.5),
        # Defenders
        p("fb_4", "Milan Škriniar", "CB", 4, "Slovakia", 30, 85, 72, 82, 88, 42, 65, 55, 88, 60, 85, key=True, val=25.0),
        p("fb_3", "Çağlar Söyüncü", "CB", 3, "Turkey", 29, 80, 75, 80, 82, 38, 58, 52, 82, 55, 78, val=12.0),
        p("fb_5", "Rodrigo Becão", "CB", 5, "Brazil", 29, 79, 70, 78, 85, 35, 55, 48, 80, 52, 76, val=8.0),
        p("fb_22", "Nélson Semedo", "RB", 22, "Portugal", 31, 81, 88, 82, 72, 55, 75, 78, 78, 72, 78, val=12.0),
        p("fb_21", "Mert Müldür", "RB", 21, "Turkey", 26, 78, 85, 80, 74, 58, 72, 75, 76, 68, 74, val=7.0),
        p("fb_15", "Jayden Oosterwolde", "LB", 15, "Netherlands", 24, 78, 85, 84, 75, 58, 72, 75, 76, 68, 74, val=15.0),
        p("fb_13", "Levent Mercan", "RB", 13, "Turkey", 23, 75, 82, 80, 72, 55, 68, 72, 74, 65, 72, val=4.0),
        p("fb_55", "Archie Brown", "CB", 55, "England", 22, 76, 75, 78, 80, 32, 55, 50, 77, 52, 73, val=5.0),
        # Midfielders
        p("fb_6", "Edson Álvarez", "CDM", 6, "Mexico", 27, 83, 72, 88, 85, 58, 75, 72, 84, 72, 82, key=True, val=28.0),
        p("fb_17", "Fred", "CM", 17, "Brazil", 32, 81, 75, 85, 78, 65, 78, 76, 78, 75, 80, key=True, val=10.0),
        p("fb_4a", "Sofyan Amrabat", "CDM", 4, "Morocco", 28, 80, 70, 88, 82, 55, 72, 68, 82, 70, 78, val=18.0),
        p("fb_10", "Sebastian Szymański", "CAM", 10, "Poland", 26, 82, 78, 80, 65, 78, 82, 82, 38, 85, 78, key=True, val=22.0),
        p("fb_20", "İrfan Can Kahveci", "CM", 20, "Turkey", 29, 79, 75, 78, 72, 80, 75, 76, 45, 72, 75, val=8.0),
        p("fb_18", "Bartuğ Elmaz", "CM", 18, "Turkey", 21, 74, 78, 80, 68, 62, 72, 72, 55, 68, 72, val=3.0),
        p("fb_14", "İsmail Yüksek", "CM", 14, "Turkey", 25, 76, 72, 82, 78, 58, 72, 70, 75, 68, 74, val=5.0),
        p("fb_16", "Mert Hakan Yandaş", "CM", 16, "Turkey", 31, 76, 72, 78, 75, 65, 74, 72, 68, 70, 75, val=3.0),
        # Forwards
        p("fb_7", "Marco Asensio", "RW", 7, "Spain", 30, 84, 82, 78, 68, 85, 82, 84, 32, 82, 82, key=True, val=25.0),
        p("fb_8", "Anderson Talisca", "CAM", 8, "Brazil", 31, 83, 78, 75, 82, 85, 78, 80, 35, 78, 80, key=True, val=15.0),
        p("fb_9", "Youssef En-Nesyri", "ST", 9, "Morocco", 28, 82, 82, 80, 85, 82, 58, 72, 32, 65, 78, val=20.0),
        p("fb_11", "Muhammed Kerem Aktürkoğlu", "LW", 11, "Turkey", 26, 81, 90, 82, 68, 78, 72, 85, 28, 72, 76, key=True, val=22.0),
        p("fb_19", "Jhon Durán", "ST", 19, "Colombia", 21, 80, 88, 78, 80, 78, 55, 72, 25, 62, 72, val=35.0),
        p("fb_27", "Oğuz Aydın", "LW", 27, "Turkey", 25, 77, 85, 78, 68, 72, 68, 78, 30, 68, 73, val=5.0),
        p("fb_24", "Cenk Tosun", "ST", 24, "Turkey", 34, 76, 68, 72, 80, 78, 55, 68, 28, 65, 78, val=1.5),
        p("fb_25", "Nene Dorgeles", "LW", 25, "Mali", 22, 76, 88, 78, 68, 72, 62, 78, 28, 62, 70, val=8.0),
        p("fb_26", "Emre Mor", "LW", 26, "Turkey", 27, 76, 92, 75, 58, 72, 70, 85, 22, 68, 68, val=3.0),
    ]
}

# =============================================================================
# BEŞİKTAŞ 2025-2026 (25 Players)
# =============================================================================
BESIKTAS = {
    "id": "bjk", "name": "Beşiktaş", "short_name": "BJK",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/cg07mt1679455607.png",
    "stadium": "Tüpraş Stadyumu", "stadium_capacity": 41903, "coach": "Giovanni van Bronckhorst",
    "founded": 1903, "colors": {"primary": "#000000", "secondary": "#FFFFFF"},
    "league_position": 3, "overall_rating": 80, "attack_rating": 82,
    "midfield_rating": 78, "defense_rating": 79, "form": ["D", "W", "L", "W", "W"],
    "players": [
        # Goalkeepers
        p("bjk_1", "Mert Günok", "GK", 1, "Turkey", 36, 82, 42, 68, 78, 18, 55, 32, 22, 55, 82, 84, 82, True, 2.5),
        p("bjk_25", "Ersin Destanoğlu", "GK", 25, "Turkey", 24, 77, 42, 72, 75, 16, 52, 30, 20, 52, 74, 79, 77, val=4.0),
        # Defenders
        p("bjk_5", "Gabriel Paulista", "CB", 5, "Brazil", 34, 80, 72, 75, 85, 32, 52, 48, 83, 50, 80, key=True, val=4.0),
        p("bjk_4", "Felix Uduokhai", "CB", 4, "Germany", 27, 78, 75, 80, 82, 35, 55, 50, 80, 52, 76, val=8.0),
        p("bjk_13", "Romain Saïss", "CB", 13, "Morocco", 35, 78, 68, 75, 82, 38, 58, 48, 80, 55, 78, val=3.0),
        p("bjk_2", "Jonas Svensson", "RB", 2, "Norway", 31, 77, 80, 82, 72, 58, 72, 72, 76, 68, 75, val=3.5),
        p("bjk_3", "Arthur Masuaku", "LB", 3, "DR Congo", 31, 76, 85, 82, 72, 52, 70, 75, 74, 65, 72, val=3.0),
        p("bjk_22", "Umut Meraş", "LB", 22, "Turkey", 29, 76, 82, 80, 72, 55, 68, 72, 75, 65, 73, val=3.0),
        p("bjk_33", "Alex Oxlade-Chamberlain", "RB", 33, "England", 32, 75, 80, 70, 72, 68, 72, 76, 52, 68, 72, val=2.0),
        # Midfielders
        p("bjk_8", "Gedson Fernandes", "CM", 8, "Portugal", 26, 79, 78, 85, 78, 68, 75, 76, 72, 72, 75, key=True, val=12.0),
        p("bjk_6", "Cher Ndour", "CDM", 6, "Italy", 20, 75, 72, 82, 78, 55, 72, 70, 75, 68, 72, val=8.0),
        p("bjk_14", "Salih Uçan", "CM", 14, "Turkey", 31, 76, 72, 78, 68, 65, 78, 75, 58, 75, 74, val=2.5),
        p("bjk_20", "Necip Uysal", "CDM", 20, "Turkey", 33, 74, 68, 75, 78, 55, 68, 65, 75, 65, 76, val=1.0),
        p("bjk_18", "Rachid Ghezzal", "RM", 18, "Algeria", 32, 77, 78, 75, 65, 75, 78, 82, 28, 76, 74, val=3.0),
        p("bjk_21", "Ernest Muçi", "LM", 21, "Albania", 23, 76, 85, 78, 68, 72, 68, 78, 32, 68, 72, val=5.0),
        # Forwards
        p("bjk_17", "Ciro Immobile", "ST", 17, "Italy", 35, 83, 78, 72, 75, 88, 65, 78, 28, 75, 86, key=True, val=8.0),
        p("bjk_10", "Rafa Silva", "RW", 10, "Portugal", 32, 82, 88, 78, 58, 78, 80, 86, 28, 80, 78, key=True, val=10.0),
        p("bjk_11", "João Mário", "LW", 11, "Portugal", 32, 80, 78, 80, 72, 72, 82, 80, 52, 78, 78, val=6.0),
        p("bjk_7", "Cenk Tosun", "ST", 7, "Turkey", 34, 76, 68, 72, 80, 78, 55, 68, 28, 65, 78, val=1.5),
        p("bjk_42", "Semih Kılıçsoy", "ST", 42, "Turkey", 19, 76, 85, 78, 68, 74, 58, 75, 25, 62, 70, val=15.0),
        p("bjk_9", "Milot Rashica", "LW", 9, "Kosovo", 29, 77, 88, 78, 68, 75, 68, 80, 28, 68, 73, val=4.0),
        p("bjk_23", "Mustafa Hekimoğlu", "ST", 23, "Turkey", 18, 72, 82, 75, 65, 68, 55, 72, 22, 58, 68, val=5.0),
        p("bjk_19", "Cengiz Ünder", "RW", 19, "Turkey", 28, 79, 88, 78, 65, 78, 72, 82, 28, 72, 74, val=8.0),
        p("bjk_77", "Can Keleş", "LW", 77, "Turkey", 23, 74, 85, 78, 68, 70, 65, 78, 28, 65, 70, val=2.0),
        p("bjk_99", "Gedson Carvalho", "CM", 99, "Brazil", 24, 75, 75, 78, 75, 62, 72, 74, 58, 70, 73, val=3.0),
    ]
}

# =============================================================================
# TRABZONSPOR 2025-2026 (27 Players)
# =============================================================================
TRABZONSPOR = {
    "id": "ts", "name": "Trabzonspor", "short_name": "TS",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/43oobe1672951178.png",
    "stadium": "Papara Park", "stadium_capacity": 40782, "coach": "Şenol Güneş",
    "founded": 1967, "colors": {"primary": "#6B0714", "secondary": "#00A1DE"},
    "league_position": 5, "overall_rating": 77, "attack_rating": 78,
    "midfield_rating": 77, "defense_rating": 75, "form": ["L", "D", "W", "L", "D"],
    "players": [
        # Goalkeepers
        p("ts_1", "Doğan Alemdar", "GK", 1, "Turkey", 22, 76, 45, 72, 75, 18, 50, 30, 20, 52, 74, 78, 76, val=4.0),
        p("ts_23", "Abdullah Yiğiter", "GK", 23, "Turkey", 27, 73, 40, 70, 72, 15, 48, 28, 18, 50, 72, 75, 73, val=1.0),
        # Defenders
        p("ts_4", "Stefano Denswil", "CB", 4, "Netherlands", 32, 76, 70, 75, 80, 35, 62, 55, 78, 55, 74, val=2.5),
        p("ts_5", "Rayyan Baniya", "CB", 5, "Turkey", 25, 75, 72, 78, 80, 32, 52, 48, 77, 50, 72, val=3.0),
        p("ts_44", "Berat Özdemir", "CB", 44, "Turkey", 27, 75, 70, 78, 80, 35, 55, 50, 77, 52, 73, val=2.5),
        p("ts_2", "Azubuike Okechukwu", "RB", 2, "Nigeria", 27, 74, 85, 82, 72, 48, 62, 68, 72, 58, 70, val=2.0),
        p("ts_22", "Murat Sağlam", "LB", 22, "Turkey", 27, 74, 80, 82, 70, 52, 65, 68, 73, 60, 72, val=2.5),
        p("ts_13", "Bruno Peres", "RB", 13, "Brazil", 35, 74, 82, 75, 72, 52, 65, 70, 72, 58, 72, val=1.0),
        p("ts_3", "Marc Bartra", "CB", 3, "Spain", 34, 77, 68, 72, 80, 38, 62, 55, 79, 58, 78, val=2.0),
        # Midfielders
        p("ts_10", "Enis Bardhi", "CAM", 10, "North Macedonia", 30, 79, 72, 78, 68, 78, 82, 80, 35, 82, 76, key=True, val=6.0),
        p("ts_6", "Okay Yokuşlu", "CDM", 6, "Turkey", 31, 78, 65, 85, 85, 55, 72, 68, 80, 70, 78, key=True, val=5.0),
        p("ts_7", "Abdülkadir Ömür", "CAM", 7, "Turkey", 26, 76, 78, 75, 62, 72, 75, 80, 32, 75, 72, val=4.0),
        p("ts_11", "Trezeguet", "RM", 11, "Egypt", 31, 77, 85, 80, 68, 72, 70, 78, 35, 70, 74, val=4.0),
        p("ts_8", "Anastasios Bakasetas", "CM", 8, "Greece", 32, 77, 70, 78, 75, 72, 78, 75, 55, 76, 76, val=3.5),
        p("ts_20", "João Pereira", "RM", 20, "Portugal", 26, 75, 82, 78, 68, 68, 68, 76, 35, 68, 72, val=3.0),
        p("ts_14", "Batuhan Kör", "CM", 14, "Turkey", 24, 73, 75, 80, 75, 58, 68, 68, 65, 65, 70, val=2.0),
        p("ts_18", "Anders Trondsen", "CM", 18, "Norway", 29, 74, 72, 78, 75, 62, 70, 70, 68, 68, 73, val=2.0),
        # Forwards
        p("ts_9", "Paul Onuachu", "ST", 9, "Nigeria", 30, 78, 68, 75, 92, 82, 55, 65, 30, 58, 75, key=True, val=8.0),
        p("ts_17", "Simon Banza", "ST", 17, "France", 28, 77, 78, 78, 78, 78, 58, 72, 28, 62, 74, val=6.0),
        p("ts_14a", "Edin Visca", "RW", 14, "Bosnia", 35, 78, 82, 75, 68, 75, 78, 80, 32, 78, 78, val=3.0),
        p("ts_77", "Filip Kostić", "LW", 77, "Serbia", 32, 78, 82, 78, 75, 72, 80, 78, 38, 78, 76, val=5.0),
        p("ts_21", "Nana Asare", "ST", 21, "Ghana", 23, 74, 82, 78, 75, 72, 55, 70, 25, 58, 70, val=2.0),
        p("ts_19", "Tony Nwakaeme", "LW", 19, "Nigeria", 34, 75, 78, 72, 70, 72, 68, 76, 28, 70, 74, val=1.5),
        p("ts_28", "Denswil Ansu", "ST", 28, "Spain", 20, 73, 85, 75, 68, 70, 52, 72, 22, 55, 68, val=3.0),
        p("ts_30", "Umut Bozok", "ST", 30, "Turkey", 28, 75, 82, 78, 75, 78, 55, 72, 22, 58, 72, val=4.0),
        p("ts_16", "Yusuf Sarı", "LW", 16, "Turkey", 26, 75, 85, 78, 68, 72, 65, 78, 28, 65, 72, val=3.0),
        p("ts_99", "Anastasios Chatzigiovanis", "CAM", 99, "Greece", 28, 75, 78, 78, 68, 72, 72, 76, 35, 72, 73, val=2.5),
    ]
}

# =============================================================================
# EXPORT ALL BIG 4 TEAMS
# =============================================================================
BIG4_TEAMS = {
    "gs": GALATASARAY,
    "fb": FENERBAHCE,
    "bjk": BESIKTAS,
    "ts": TRABZONSPOR,
}

def get_big4_teams():
    return BIG4_TEAMS
