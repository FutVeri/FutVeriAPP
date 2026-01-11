"""
Süper Lig 2025-2026 - Anadolu Teams Part 1
ANTALYASPOR, KASIMPASA, SAMSUNSPOR, GENCLERBIRLIGI, EYUPSPOR, KONYASPOR, RIZESPOR
"""
from app.data.super_lig_teams_players import p

# =============================================================================
# ANTALYASPOR (20 Players)
# =============================================================================
ANTALYASPOR = {
    "id": "ant", "name": "Antalyaspor", "short_name": "ANT",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/vqoral1601669436.png",
    "stadium": "Corendon Airlines Park", "stadium_capacity": 32539, "coach": "Alex de Souza",
    "colors": {"primary": "#D50032", "secondary": "#FFFFFF"},
    "overall_rating": 73, "attack_rating": 74, "midfield_rating": 72, "defense_rating": 73,
    "form": ["L", "D", "W", "L", "W"],
    "players": [
        p("ant_1", "Julián Cuesta", "GK", 1, "Colombia", 34, 75, 40, 68, 76, 15, 48, 28, 18, 50, 74, 77, 75, val=1.0),
        p("ant_23", "Ataberk Dadakdeniz", "GK", 23, "Turkey", 26, 73, 40, 70, 72, 14, 46, 26, 16, 48, 72, 74, 73, val=1.0),
        p("ant_3", "Naldo", "CB", 3, "Brazil", 32, 76, 68, 75, 82, 32, 52, 45, 78, 50, 74, val=2.0),
        p("ant_4", "Adil Demirbağ", "CB", 4, "Turkey", 31, 74, 68, 76, 80, 30, 50, 45, 76, 48, 73, val=1.5),
        p("ant_5", "Veysel Sarı", "CB", 5, "Turkey", 34, 73, 65, 72, 80, 28, 52, 42, 75, 50, 75, val=0.8),
        p("ant_2", "Soner Aydoğdu", "RB", 2, "Turkey", 34, 74, 78, 75, 72, 52, 68, 70, 74, 62, 74, val=1.0),
        p("ant_22", "Fernando", "LB", 22, "Brazil", 32, 75, 80, 78, 74, 55, 68, 72, 75, 62, 73, val=1.5),
        p("ant_6", "Nuri Şahin", "CDM", 6, "Turkey", 37, 75, 58, 68, 72, 62, 78, 72, 72, 80, 82, key=True, val=0.5),
        p("ant_8", "Hakan Özmert", "CM", 8, "Turkey", 36, 73, 65, 70, 70, 68, 75, 72, 55, 75, 76, val=0.5),
        p("ant_10", "Lukas Podolski", "CAM", 10, "Germany", 41, 72, 58, 62, 75, 78, 75, 72, 28, 75, 80, key=True, val=0.5),
        p("ant_14", "Vato Arveladze", "CM", 14, "Georgia", 29, 74, 75, 78, 72, 65, 72, 72, 58, 68, 72, val=2.0),
        p("ant_7", "Haji Wright", "ST", 7, "USA", 27, 76, 80, 78, 82, 76, 55, 72, 25, 58, 72, key=True, val=5.0),
        p("ant_9", "Fernando Andrade", "ST", 9, "Brazil", 31, 75, 78, 76, 78, 76, 55, 70, 25, 58, 72, key=True, val=2.5),
        p("ant_11", "Fredy", "LW", 11, "Senegal", 26, 74, 88, 78, 68, 72, 58, 76, 25, 58, 70, val=2.0),
        p("ant_17", "Alassane Ndao", "RW", 17, "Senegal", 27, 75, 88, 80, 70, 74, 62, 78, 28, 62, 72, val=3.0),
        p("ant_19", "Güray Vural", "LM", 19, "Turkey", 33, 72, 78, 72, 68, 68, 70, 74, 35, 68, 73, val=0.8),
        p("ant_20", "Gilberto", "RW", 20, "Brazil", 30, 74, 85, 78, 70, 72, 62, 76, 28, 62, 71, val=2.0),
        p("ant_21", "Yusuf Erdoğan", "CM", 21, "Turkey", 32, 73, 72, 75, 70, 68, 72, 72, 52, 70, 73, val=1.0),
        p("ant_25", "Ufuk Akyol", "CM", 25, "Turkey", 31, 73, 72, 78, 72, 62, 70, 70, 62, 68, 72, val=1.0),
        p("ant_99", "Oscar Trejo", "CAM", 99, "Argentina", 37, 74, 62, 68, 65, 72, 78, 76, 32, 80, 78, val=0.5),
    ]
}

# =============================================================================
# KASIMPASA (22 Players)
# =============================================================================
KASIMPASA = {
    "id": "kas", "name": "Kasımpaşa", "short_name": "KAS",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/uryxtp1448203236.png",
    "stadium": "Recep Tayyip Erdoğan Stadyumu", "stadium_capacity": 14234, "coach": "Fuat Çapa",
    "colors": {"primary": "#0047AB", "secondary": "#FFD700"},
    "overall_rating": 74, "attack_rating": 75, "midfield_rating": 74, "defense_rating": 73,
    "form": ["D", "L", "D", "W", "L"],
    "players": [
        p("kas_1", "Andreas Gianniotis", "GK", 1, "Greece", 28, 75, 42, 70, 76, 16, 52, 30, 20, 52, 74, 77, 75, val=1.5),
        p("kas_23", "Ali Emre Yanar", "GK", 23, "Turkey", 25, 72, 40, 68, 72, 14, 48, 28, 18, 50, 72, 74, 72, val=0.5),
        p("kas_4", "Attila Szalai", "CB", 4, "Hungary", 27, 78, 75, 80, 82, 35, 58, 55, 80, 55, 76, key=True, val=10.0),
        p("kas_5", "Nicholas Opoku", "CB", 5, "Ghana", 27, 76, 72, 78, 82, 32, 52, 48, 78, 50, 74, val=3.0),
        p("kas_3", "Adem Arous", "CB", 3, "Algeria", 28, 74, 70, 76, 80, 30, 50, 45, 76, 48, 72, val=1.5),
        p("kas_2", "Florent Hadergjonaj", "RB", 2, "Kosovo", 30, 75, 82, 80, 72, 52, 68, 72, 74, 62, 72, val=2.0),
        p("kas_22", "Cláudio Winck", "LB", 22, "Brazil", 33, 74, 78, 76, 72, 55, 68, 70, 74, 62, 73, val=1.0),
        p("kas_6", "Cafú", "CDM", 6, "Portugal", 31, 76, 70, 80, 78, 58, 72, 68, 78, 68, 76, key=True, val=2.5),
        p("kas_8", "Andri Baldursson", "CM", 8, "Iceland", 23, 74, 78, 80, 72, 62, 72, 72, 62, 70, 72, val=2.0),
        p("kas_10", "Haris Hajradinović", "CAM", 10, "Bosnia", 30, 77, 75, 78, 68, 75, 78, 78, 35, 78, 74, key=True, val=3.5),
        p("kas_14", "Mortadha Ben Ouanes", "CM", 14, "Tunisia", 28, 74, 78, 78, 70, 65, 72, 72, 58, 68, 72, val=1.5),
        p("kas_18", "Mamadou Fall", "CM", 18, "Senegal", 26, 74, 78, 82, 75, 58, 68, 68, 72, 62, 70, val=2.0),
        p("kas_7", "Fousseni Diabaté", "LW", 7, "Mali", 29, 76, 90, 78, 68, 74, 62, 80, 25, 62, 70, val=2.5),
        p("kas_9", "Pape Habib Guèye", "ST", 9, "Senegal", 30, 76, 80, 78, 82, 78, 55, 72, 28, 58, 74, key=True, val=4.0),
        p("kas_11", "Kubilay Kanatsızkuş", "ST", 11, "Turkey", 30, 75, 78, 76, 78, 76, 58, 72, 25, 62, 73, val=2.0),
        p("kas_17", "Yusuf Barası", "RW", 17, "Turkey", 27, 75, 85, 78, 68, 74, 62, 78, 28, 62, 72, val=2.5),
        p("kas_19", "Oğuzhan Yılmaz", "LM", 19, "Turkey", 25, 73, 82, 78, 68, 68, 65, 75, 32, 65, 70, val=1.5),
        p("kas_20", "Cem Üstündağ", "CM", 20, "Turkey", 28, 73, 75, 78, 72, 62, 70, 70, 58, 68, 72, val=1.0),
        p("kas_21", "Atakan Müjde", "LB", 21, "Turkey", 24, 73, 80, 78, 70, 52, 65, 68, 73, 58, 70, val=1.0),
        p("kas_25", "Yasin Eratilla", "RW", 25, "Turkey", 22, 72, 85, 76, 65, 68, 58, 76, 25, 58, 68, val=1.0),
        p("kas_27", "Taylan Aydın", "CB", 27, "Turkey", 26, 73, 72, 76, 78, 30, 52, 48, 75, 50, 72, val=1.0),
        p("kas_30", "Jhon Espinoza", "LB", 30, "Ecuador", 27, 74, 82, 80, 74, 52, 65, 70, 74, 58, 71, val=1.5),
    ]
}

# =============================================================================
# SAMSUNSPOR (24 Players)
# =============================================================================
SAMSUNSPOR = {
    "id": "sam", "name": "Samsunspor", "short_name": "SAM",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/vz05y71679456608.png",
    "stadium": "Samsun 19 Mayıs Stadyumu", "stadium_capacity": 33919, "coach": "Thomas Reis",
    "colors": {"primary": "#E4002B", "secondary": "#FFFFFF"},
    "overall_rating": 74, "attack_rating": 75, "midfield_rating": 74, "defense_rating": 73,
    "form": ["W", "W", "D", "L", "W"],
    "players": [
        p("sam_1", "Okan Kocuk", "GK", 1, "Turkey", 32, 75, 40, 70, 76, 16, 52, 30, 20, 52, 74, 77, 75, val=1.5),
        p("sam_23", "Albert Posiadala", "GK", 23, "Poland", 26, 73, 42, 70, 74, 15, 50, 28, 18, 50, 72, 75, 73, val=0.8),
        p("sam_4", "Lubomir Satka", "CB", 4, "Slovakia", 29, 76, 72, 78, 82, 32, 55, 50, 78, 52, 74, key=True, val=3.0),
        p("sam_5", "Rick Van Drongelen", "CB", 5, "Netherlands", 26, 75, 72, 78, 82, 32, 52, 48, 77, 50, 73, val=2.5),
        p("sam_3", "Toni Borevkovic", "CB", 3, "Croatia", 27, 75, 70, 76, 82, 30, 52, 48, 77, 50, 73, val=2.0),
        p("sam_2", "Josafat Mendes", "RB", 2, "Cape Verde", 27, 75, 82, 80, 74, 52, 68, 72, 75, 62, 72, val=2.0),
        p("sam_22", "Zeki Yavru", "LB", 22, "Turkey", 32, 74, 78, 78, 72, 52, 65, 70, 74, 60, 74, val=1.0),
        p("sam_6", "Antoine Makoumbou", "CDM", 6, "Congo", 28, 76, 72, 82, 80, 58, 72, 68, 78, 65, 74, key=True, val=3.0),
        p("sam_8", "Jules Olivier Ntcham", "CM", 8, "Cameroon", 29, 76, 75, 78, 75, 68, 75, 76, 62, 72, 74, key=True, val=3.5),
        p("sam_10", "Emre Kılınç", "CAM", 10, "Turkey", 30, 77, 78, 78, 68, 75, 78, 80, 35, 78, 76, key=True, val=4.0),
        p("sam_14", "Soner Aydoğdu", "CM", 14, "Turkey", 34, 74, 72, 75, 72, 65, 72, 70, 62, 72, 75, val=1.0),
        p("sam_18", "Tanguy Coulibaly", "LW", 18, "Germany", 23, 76, 88, 78, 68, 74, 65, 80, 28, 65, 72, val=3.0),
        p("sam_7", "Anthony Musaba", "RW", 7, "Netherlands", 24, 77, 90, 80, 70, 76, 65, 82, 28, 65, 72, key=True, val=5.0),
        p("sam_9", "Pape Cherif Ndiaye", "ST", 9, "Senegal", 31, 76, 78, 78, 82, 78, 55, 72, 28, 58, 74, key=True, val=4.0),
        p("sam_11", "Carl Johan Holse", "RW", 11, "Denmark", 27, 76, 85, 80, 68, 74, 72, 78, 28, 70, 74, key=True, val=4.0),
        p("sam_17", "Marius Moundilmadji", "ST", 17, "Chad", 22, 74, 82, 78, 80, 74, 52, 70, 25, 55, 70, val=2.0),
        p("sam_19", "Polat Yaldır", "LW", 19, "Turkey", 22, 73, 85, 78, 65, 70, 60, 76, 25, 58, 68, val=1.5),
        p("sam_20", "Bedirhan Çetin", "CM", 20, "Turkey", 24, 73, 75, 80, 72, 60, 68, 68, 62, 65, 70, val=1.0),
        p("sam_21", "Eyüp Değirmenci", "LB", 21, "Turkey", 23, 72, 80, 78, 70, 50, 62, 65, 72, 55, 68, val=0.8),
        p("sam_25", "Yunus Emre Çift", "RB", 25, "Turkey", 24, 72, 80, 78, 70, 50, 62, 68, 72, 55, 68, val=0.8),
        p("sam_27", "Logi Tomasson", "CB", 27, "Iceland", 27, 74, 70, 76, 80, 30, 52, 48, 76, 50, 72, val=1.5),
        p("sam_28", "Soner Gönül", "RB", 28, "Turkey", 27, 73, 82, 78, 72, 52, 65, 70, 73, 58, 71, val=1.0),
        p("sam_30", "Afonso Sousa", "CAM", 30, "Portugal", 25, 75, 78, 78, 65, 72, 76, 78, 38, 75, 73, val=2.5),
        p("sam_33", "Tahsin Bülbül", "ST", 33, "Turkey", 21, 72, 82, 76, 70, 70, 52, 72, 22, 55, 68, val=1.0),
    ]
}

# =============================================================================
# GENÇLERBİRLİĞİ (22 Players)
# =============================================================================
GENCLERBIRLIGI = {
    "id": "gen", "name": "Gençlerbirliği", "short_name": "GEN",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/5hnd1c1639569938.png",
    "stadium": "Eryaman Stadyumu", "stadium_capacity": 20560, "coach": "Mustafa Kaplan",
    "colors": {"primary": "#ED1C24", "secondary": "#000000"},
    "overall_rating": 72, "attack_rating": 72, "midfield_rating": 72, "defense_rating": 71,
    "form": ["L", "L", "D", "L", "D"],
    "players": [
        p("gen_1", "Ricardo Velho", "GK", 1, "Portugal", 27, 74, 42, 70, 74, 15, 50, 28, 18, 50, 73, 76, 74, val=1.0),
        p("gen_23", "Gökhan Akkan", "GK", 23, "Turkey", 32, 73, 38, 68, 74, 14, 48, 26, 18, 50, 72, 75, 73, val=0.8),
        p("gen_4", "Isaac Cofie", "CB", 4, "Ghana", 33, 73, 65, 72, 80, 28, 50, 42, 75, 48, 72, val=0.5),
        p("gen_5", "Onur Ergun", "CB", 5, "Turkey", 28, 73, 68, 75, 78, 28, 50, 45, 75, 48, 72, val=1.0),
        p("gen_3", "Mert Çetin", "CB", 3, "Turkey", 27, 74, 70, 76, 80, 30, 52, 48, 76, 50, 73, val=2.0),
        p("gen_2", "Blaise Matuidi", "RB", 2, "France", 38, 73, 68, 70, 78, 52, 72, 68, 78, 72, 80, val=0.3),
        p("gen_22", "Furkan Yaman", "LB", 22, "Turkey", 26, 72, 80, 78, 70, 50, 62, 68, 72, 55, 68, val=0.8),
        p("gen_6", "Yohan Boli", "CM", 6, "Ivory Coast", 32, 74, 72, 78, 78, 62, 70, 68, 72, 68, 74, key=True, val=1.5),
        p("gen_8", "Nikola Storm", "CAM", 8, "Belgium", 29, 75, 78, 78, 68, 72, 76, 78, 35, 75, 74, key=True, val=2.5),
        p("gen_10", "Alper Potuk", "CM", 10, "Turkey", 35, 74, 68, 72, 68, 70, 76, 74, 45, 75, 76, key=True, val=0.5),
        p("gen_14", "Safa Budak", "CM", 14, "Turkey", 24, 72, 75, 78, 70, 60, 68, 70, 58, 65, 70, val=0.8),
        p("gen_18", "Caner Erkin", "LM", 18, "Turkey", 37, 71, 70, 68, 68, 62, 70, 72, 58, 72, 75, val=0.3),
        p("gen_7", "Sefa Yılmaz", "LW", 7, "Turkey", 28, 74, 85, 78, 65, 72, 65, 76, 25, 62, 70, key=True, val=2.0),
        p("gen_9", "Mbwana Samatta", "ST", 9, "Tanzania", 32, 75, 82, 78, 80, 76, 55, 72, 28, 58, 74, key=True, val=2.5),
        p("gen_11", "Leke James", "ST", 11, "Nigeria", 31, 74, 78, 76, 78, 75, 55, 70, 28, 58, 73, val=1.5),
        p("gen_17", "Yasin Öztekin", "RW", 17, "Turkey", 38, 72, 72, 65, 62, 70, 70, 74, 28, 72, 75, val=0.3),
        p("gen_19", "Hamza Çakır", "LW", 19, "Turkey", 23, 72, 85, 76, 65, 68, 58, 76, 25, 58, 68, val=0.8),
        p("gen_20", "Emir Karakava", "CM", 20, "Turkey", 22, 71, 75, 78, 68, 58, 65, 68, 55, 62, 68, val=0.5),
        p("gen_21", "Serkan Bakan", "RB", 21, "Turkey", 30, 72, 78, 76, 70, 50, 62, 68, 72, 55, 70, val=0.5),
        p("gen_25", "Dzenan Burekovic", "CB", 25, "Bosnia", 27, 73, 68, 76, 80, 28, 48, 45, 75, 48, 71, val=1.0),
        p("gen_27", "Ali Demirel", "GK", 27, "Turkey", 24, 71, 40, 68, 72, 14, 46, 26, 16, 48, 70, 73, 71, val=0.3),
        p("gen_30", "Emrecan Uzunhan", "CM", 30, "Turkey", 24, 71, 75, 78, 70, 58, 65, 68, 55, 62, 68, val=0.5),
    ]
}

# =============================================================================
# EYÜPSPOR (22 Players)
# =============================================================================
EYUPSPOR = {
    "id": "eyp", "name": "Eyüpspor", "short_name": "EYP",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/7fb0ub1626445710.png",
    "stadium": "Alibeyköy Stadyumu", "stadium_capacity": 12000, "coach": "Arda Turan",
    "colors": {"primary": "#1C1C1C", "secondary": "#FFD700"},
    "overall_rating": 73, "attack_rating": 74, "midfield_rating": 74, "defense_rating": 72,
    "form": ["L", "D", "W", "L", "L"],
    "players": [
        p("eyp_1", "Ataberk Dadakdeniz", "GK", 1, "Turkey", 26, 73, 40, 70, 72, 14, 46, 26, 16, 48, 72, 74, 73, val=1.0),
        p("eyp_23", "Emir Ortakaya", "GK", 23, "Turkey", 23, 71, 40, 68, 70, 14, 46, 26, 16, 48, 70, 73, 71, val=0.5),
        p("eyp_4", "Samu Costa", "CB", 4, "Spain", 28, 74, 68, 76, 78, 30, 52, 45, 76, 50, 72, val=1.5),
        p("eyp_5", "Bertug Yildirim", "CB", 5, "Turkey", 27, 73, 68, 76, 80, 28, 50, 45, 75, 48, 72, val=1.0),
        p("eyp_3", "Atakan Karazor", "CB", 3, "Turkey", 28, 75, 70, 78, 82, 35, 58, 52, 77, 55, 75, key=True, val=3.0),
        p("eyp_2", "Mert Yilmaz", "RB", 2, "Turkey", 25, 73, 82, 78, 70, 52, 65, 70, 73, 58, 70, val=1.5),
        p("eyp_22", "Tarik Kadric", "LB", 22, "Bosnia", 30, 73, 78, 78, 72, 50, 65, 68, 74, 58, 72, val=1.0),
        p("eyp_6", "Aziz Behich", "LB", 6, "Australia", 34, 74, 82, 78, 72, 52, 68, 72, 75, 62, 74, val=1.0),
        p("eyp_8", "Arda Kizildag", "CDM", 8, "Turkey", 24, 73, 72, 80, 75, 58, 68, 68, 75, 62, 70, val=1.5),
        p("eyp_10", "Ahmed Kutucu", "CAM", 10, "Turkey", 24, 76, 82, 80, 72, 75, 72, 78, 35, 72, 74, key=True, val=5.0),
        p("eyp_14", "Moha", "CM", 14, "Spain", 30, 74, 75, 78, 70, 68, 75, 74, 55, 72, 74, val=1.5),
        p("eyp_18", "Erdi Dikmen", "CM", 18, "Turkey", 27, 73, 75, 78, 70, 62, 70, 70, 58, 68, 72, val=1.0),
        p("eyp_7", "Thijs Dallinga", "ST", 7, "Netherlands", 25, 76, 82, 78, 78, 78, 55, 74, 28, 62, 72, key=True, val=4.0),
        p("eyp_9", "Umut Bozok", "ST", 9, "Turkey", 28, 75, 82, 78, 75, 78, 55, 72, 22, 58, 72, key=True, val=4.0),
        p("eyp_11", "Ali Akman", "ST", 11, "Turkey", 22, 74, 82, 78, 72, 74, 52, 74, 25, 58, 70, val=2.5),
        p("eyp_17", "Muhammet Ozkal", "LW", 17, "Turkey", 23, 73, 85, 78, 65, 70, 60, 76, 25, 58, 68, val=1.0),
        p("eyp_19", "Berat Ayberk Ozdemir", "RM", 19, "Turkey", 26, 74, 82, 78, 68, 70, 68, 76, 35, 68, 72, val=2.0),
        p("eyp_20", "Bertug Burak", "CM", 20, "Turkey", 22, 71, 75, 78, 68, 58, 65, 68, 55, 62, 68, val=0.5),
        p("eyp_21", "Egor Nazarina", "LW", 21, "Ukraine", 24, 73, 85, 78, 68, 70, 62, 78, 28, 62, 70, val=1.5),
        p("eyp_25", "Recep Niyaz", "RW", 25, "Turkey", 27, 73, 85, 78, 65, 70, 62, 76, 28, 62, 70, val=1.0),
        p("eyp_27", "Efe Tatli", "CB", 27, "Turkey", 23, 72, 70, 76, 78, 28, 50, 45, 75, 48, 70, val=0.8),
        p("eyp_30", "Fofana", "CDM", 30, "Mali", 26, 73, 72, 80, 78, 55, 65, 62, 75, 60, 70, val=1.0),
    ]
}

# =============================================================================
# KONYASPOR (24 Players)
# =============================================================================
KONYASPOR = {
    "id": "kon", "name": "Konyaspor", "short_name": "KON",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/rxwptr1448203413.png",
    "stadium": "Konya Büyükşehir Stadyumu", "stadium_capacity": 42276, "coach": "Recep Uçar",
    "colors": {"primary": "#00843D", "secondary": "#FFFFFF"},
    "overall_rating": 73, "attack_rating": 73, "midfield_rating": 74, "defense_rating": 73,
    "form": ["W", "W", "L", "D", "W"],
    "players": [
        p("kon_1", "Deniz Ertaş", "GK", 1, "Turkey", 28, 74, 40, 70, 76, 15, 50, 28, 18, 50, 73, 76, 74, val=1.0),
        p("kon_23", "Bahadır Güngördü", "GK", 23, "Turkey", 26, 72, 40, 68, 74, 14, 48, 26, 16, 48, 72, 74, 72, val=0.5),
        p("kon_4", "Riechedly Bazoer", "CB", 4, "Netherlands", 28, 77, 75, 78, 82, 42, 65, 62, 78, 65, 76, key=True, val=5.0),
        p("kon_5", "Josip Calusic", "CB", 5, "Croatia", 29, 75, 68, 76, 82, 30, 52, 48, 77, 50, 73, val=2.0),
        p("kon_3", "Marko Jevtovic", "CB", 3, "Serbia", 32, 75, 68, 76, 82, 32, 55, 48, 78, 52, 74, val=1.5),
        p("kon_2", "Yasir Subaşı", "RB", 2, "Turkey", 27, 74, 82, 80, 72, 55, 68, 72, 74, 62, 72, val=2.0),
        p("kon_22", "Guilherme Sitya", "LB", 22, "Brazil", 28, 73, 80, 78, 72, 52, 65, 70, 73, 58, 71, val=1.5),
        p("kon_6", "Ufuk Akyol", "CDM", 6, "Turkey", 31, 74, 70, 78, 75, 62, 72, 68, 76, 68, 74, val=1.5),
        p("kon_8", "Guilherme", "CM", 8, "Brazil", 31, 76, 72, 80, 78, 65, 75, 72, 58, 72, 75, key=True, val=2.5),
        p("kon_10", "Enis Bardhi", "CAM", 10, "North Macedonia", 30, 77, 72, 78, 68, 78, 80, 78, 35, 80, 76, key=True, val=4.0),
        p("kon_14", "Jin-ho Jo", "CM", 14, "South Korea", 28, 74, 78, 78, 70, 68, 72, 72, 58, 70, 72, val=2.0),
        p("kon_18", "Morten Bjørlo", "CM", 18, "Norway", 26, 74, 78, 80, 72, 65, 72, 72, 62, 68, 72, val=2.0),
        p("kon_7", "Alassane Ndao", "RW", 7, "Senegal", 27, 75, 88, 80, 70, 74, 62, 78, 28, 62, 72, val=3.0),
        p("kon_9", "Jackson Muleka", "ST", 9, "DR Congo", 25, 76, 85, 78, 78, 78, 55, 76, 28, 58, 72, key=True, val=4.0),
        p("kon_11", "Marius Ștefănescu", "LW", 11, "Romania", 27, 75, 85, 78, 68, 74, 68, 80, 28, 68, 72, val=3.0),
        p("kon_17", "Umut Nayir", "ST", 17, "Turkey", 32, 74, 72, 75, 80, 76, 52, 68, 28, 58, 75, val=1.5),
        p("kon_19", "Kaan Akyazı", "LW", 19, "Turkey", 24, 73, 85, 78, 65, 70, 62, 76, 25, 62, 70, val=1.5),
        p("kon_20", "Mücahit İbrahimoğlu", "CM", 20, "Turkey", 22, 72, 75, 78, 70, 60, 68, 70, 55, 65, 68, val=1.0),
        p("kon_21", "Tunahan Taşçı", "ST", 21, "Turkey", 23, 73, 82, 78, 72, 72, 52, 72, 25, 55, 70, val=1.5),
        p("kon_25", "Pedrinho", "CAM", 25, "Brazil", 27, 75, 78, 78, 65, 72, 76, 78, 35, 75, 74, val=2.5),
        p("kon_27", "Adil Demirbağ", "CB", 27, "Turkey", 31, 74, 68, 76, 80, 30, 50, 45, 76, 48, 73, val=1.5),
        p("kon_28", "Uğurcan Yazğılı", "RB", 28, "Turkey", 25, 73, 82, 78, 70, 52, 65, 70, 73, 58, 70, val=1.0),
        p("kon_30", "Melih İbrahimoğlu", "LM", 30, "Turkey", 20, 71, 82, 78, 65, 65, 60, 74, 25, 58, 66, val=0.8),
        p("kon_33", "Melih Bostan", "ST", 33, "Turkey", 21, 72, 82, 76, 70, 70, 52, 72, 22, 55, 68, val=1.0),
    ]
}

# =============================================================================
# RİZESPOR (23 Players)
# =============================================================================
RIZESPOR = {
    "id": "rze", "name": "Rizespor", "short_name": "RZE",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/t7senr1657195719.png",
    "stadium": "Çaykur Didi Stadyumu", "stadium_capacity": 15558, "coach": "İlhan Palut",
    "colors": {"primary": "#0047BB", "secondary": "#009B3A"},
    "overall_rating": 73, "attack_rating": 74, "midfield_rating": 73, "defense_rating": 72,
    "form": ["L", "D", "L", "W", "D"],
    "players": [
        p("rze_1", "Yahia Fofana", "GK", 1, "Ivory Coast", 26, 74, 42, 72, 76, 16, 52, 30, 20, 52, 73, 76, 74, val=1.5),
        p("rze_23", "Erdem Canpolat", "GK", 23, "Turkey", 28, 72, 40, 68, 74, 14, 48, 28, 18, 50, 72, 74, 72, val=0.5),
        p("rze_4", "Modibo Sagnan", "CB", 4, "Mali", 27, 76, 75, 78, 82, 32, 55, 52, 78, 52, 74, key=True, val=4.0),
        p("rze_5", "Samet Akaydın", "CB", 5, "Turkey", 30, 76, 70, 78, 82, 32, 55, 50, 79, 52, 76, key=True, val=5.0),
        p("rze_3", "Attila Mocsi", "CB", 3, "Hungary", 28, 74, 70, 76, 80, 30, 52, 48, 76, 50, 72, val=2.0),
        p("rze_2", "Casper Højer", "RB", 2, "Denmark", 26, 74, 82, 80, 72, 55, 68, 72, 74, 62, 72, val=2.0),
        p("rze_22", "Taha Şahin", "LB", 22, "Turkey", 25, 73, 80, 78, 70, 52, 65, 68, 73, 58, 70, val=1.0),
        p("rze_6", "Qazim Laci", "CDM", 6, "Albania", 28, 75, 70, 80, 78, 58, 72, 68, 78, 65, 75, key=True, val=3.0),
        p("rze_8", "Janne-Pekka Laine", "CM", 8, "Finland", 27, 74, 78, 78, 70, 68, 72, 72, 58, 70, 72, val=2.0),
        p("rze_10", "Giannis Papanikolaou", "CAM", 10, "Greece", 27, 75, 75, 78, 68, 72, 76, 78, 38, 76, 74, val=2.5),
        p("rze_14", "İbrahim Olawoyin", "LM", 14, "Nigeria", 24, 74, 85, 78, 68, 72, 65, 78, 32, 65, 70, val=2.0),
        p("rze_18", "Muhamed Buljubasic", "CM", 18, "Bosnia", 26, 73, 75, 78, 72, 62, 70, 70, 58, 68, 72, val=1.5),
        p("rze_7", "Valentin Mihăilă", "LW", 7, "Romania", 25, 77, 88, 78, 68, 76, 68, 82, 28, 68, 72, key=True, val=5.0),
        p("rze_9", "Halil Dervişoğlu", "ST", 9, "Turkey", 25, 76, 85, 78, 68, 76, 62, 78, 22, 65, 73, key=True, val=6.0),
        p("rze_11", "Ali Sowe", "ST", 11, "Gambia", 30, 75, 78, 76, 82, 78, 52, 70, 28, 55, 74, val=2.5),
        p("rze_17", "Jesurun Rak-Sakyi", "RW", 17, "England", 22, 75, 88, 78, 68, 74, 62, 82, 25, 62, 70, val=4.0),
        p("rze_19", "Loide Augusto", "LW", 19, "Angola", 27, 74, 85, 78, 68, 72, 62, 78, 28, 62, 71, val=2.0),
        p("rze_20", "Vaclav Jurecka", "ST", 20, "Czech Republic", 30, 74, 75, 76, 78, 76, 55, 70, 28, 58, 74, val=1.5),
        p("rze_21", "Altin Zeqiri", "ST", 21, "Switzerland", 27, 74, 82, 78, 75, 74, 55, 72, 25, 58, 72, val=2.0),
        p("rze_25", "Emrecan Bulut", "RW", 25, "Turkey", 22, 72, 85, 76, 65, 68, 58, 76, 25, 58, 68, val=1.0),
        p("rze_27", "Taylan Antalyalı", "CDM", 27, "Turkey", 30, 75, 68, 78, 78, 55, 70, 68, 78, 65, 76, val=2.0),
        p("rze_28", "Furkan Orak", "RB", 28, "Turkey", 26, 73, 80, 78, 72, 52, 65, 70, 74, 58, 70, val=1.0),
        p("rze_30", "Mithat Pala", "CM", 30, "Turkey", 24, 72, 75, 78, 70, 60, 68, 68, 55, 65, 70, val=0.8),
    ]
}

# =============================================================================
# EXPORT
# =============================================================================
ANADOLU_PART1 = {
    "ant": ANTALYASPOR,
    "kas": KASIMPASA,
    "sam": SAMSUNSPOR,
    "gen": GENCLERBIRLIGI,
    "eyp": EYUPSPOR,
    "kon": KONYASPOR,
    "rze": RIZESPOR,
}
