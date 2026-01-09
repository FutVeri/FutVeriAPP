"""
Süper Lig 2025-2026 - Anadolu Teams Part 2
GOZTEPE, KOCAELISPOR, GAZIANTEP, ALANYASPOR, BASAKSEHIR, KAYSERISPOR, FATIH KARAGUMRUK
"""
from app.data.super_lig_teams_players import p

# =============================================================================
# GÖZTEPE (22 Players)
# =============================================================================
GOZTEPE = {
    "id": "goz", "name": "Göztepe", "short_name": "GOZ",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/9jwk7o1513952059.png",
    "stadium": "Gürsel Aksel Stadyumu", "stadium_capacity": 20028, "coach": "Stanimir Stoilov",
    "colors": {"primary": "#FFFF00", "secondary": "#E4002B"},
    "overall_rating": 75, "attack_rating": 75, "midfield_rating": 75, "defense_rating": 74,
    "form": ["W", "D", "W", "W", "D"],
    "players": [
        p("goz_1", "Mateusz Lis", "GK", 1, "Poland", 27, 76, 42, 70, 76, 16, 52, 30, 20, 52, 74, 78, 76, key=True, val=2.0),
        p("goz_23", "Ekrem Kılıçarslan", "GK", 23, "Turkey", 28, 73, 40, 68, 74, 15, 48, 28, 18, 50, 72, 75, 73, val=0.8),
        p("goz_4", "Taha Altıkardeş", "CB", 4, "Turkey", 26, 75, 70, 78, 80, 32, 55, 50, 78, 52, 74, val=2.5),
        p("goz_5", "Malcom Bokele", "CB", 5, "Congo", 28, 76, 72, 78, 84, 32, 52, 48, 79, 50, 74, key=True, val=3.5),
        p("goz_3", "Héliton", "CB", 3, "Brazil", 30, 75, 70, 76, 82, 30, 55, 50, 78, 52, 74, val=2.0),
        p("goz_2", "Amin Cherni", "RB", 2, "Tunisia", 26, 74, 82, 80, 72, 55, 68, 72, 74, 62, 72, val=2.0),
        p("goz_22", "İsmail Köybaşı", "LB", 22, "Turkey", 35, 73, 78, 72, 70, 52, 68, 72, 75, 65, 75, val=0.5),
        p("goz_6", "Rhaldney", "CDM", 6, "Brazil", 26, 75, 72, 80, 78, 58, 72, 70, 77, 65, 73, key=True, val=3.0),
        p("goz_8", "Anthony Dennis", "CM", 8, "Nigeria", 25, 74, 78, 80, 72, 65, 72, 72, 62, 68, 72, val=2.0),
        p("goz_10", "Arda Okan Kurtulan", "CAM", 10, "Turkey", 24, 75, 78, 78, 68, 72, 76, 78, 38, 74, 73, key=True, val=3.0),
        p("goz_14", "Efkan Bekiroğlu", "CM", 14, "Turkey", 32, 74, 72, 75, 70, 70, 75, 74, 58, 75, 76, val=1.5),
        p("goz_18", "Novatus Miroshi", "LM", 18, "Tanzania", 28, 74, 85, 78, 68, 70, 65, 76, 32, 65, 70, val=2.0),
        p("goz_7", "Janderson", "RW", 7, "Brazil", 28, 76, 88, 78, 70, 76, 65, 82, 28, 68, 72, key=True, val=4.0),
        p("goz_9", "Juan", "ST", 9, "Brazil", 30, 76, 78, 78, 82, 78, 55, 72, 28, 58, 76, key=True, val=4.0),
        p("goz_11", "İbrahim Sabra", "LW", 11, "Turkey", 27, 75, 85, 78, 68, 74, 62, 78, 28, 62, 72, val=3.0),
        p("goz_17", "Junior Olaitan", "LW", 17, "Nigeria", 26, 75, 88, 78, 70, 74, 62, 80, 28, 62, 71, val=3.0),
        p("goz_19", "Alexis Antunes", "RW", 19, "Portugal", 26, 74, 85, 78, 68, 72, 65, 78, 28, 65, 72, val=2.0),
        p("goz_20", "Uğur Kaan Yıldız", "CM", 20, "Turkey", 23, 72, 78, 78, 68, 62, 70, 70, 55, 65, 70, val=1.0),
        p("goz_21", "Allan Godói", "LB", 21, "Brazil", 27, 74, 82, 80, 74, 52, 68, 72, 75, 62, 72, val=2.0),
        p("goz_25", "Furkan Bayır", "CB", 25, "Turkey", 26, 73, 70, 76, 80, 28, 52, 48, 76, 50, 72, val=1.5),
        p("goz_27", "Ruan Teixeira", "RB", 27, "Brazil", 25, 73, 82, 78, 72, 52, 65, 70, 74, 58, 70, val=1.5),
        p("goz_30", "Tibet Durakçay", "ST", 30, "Turkey", 24, 73, 82, 76, 75, 74, 52, 72, 25, 55, 70, val=1.5),
    ]
}

# =============================================================================
# KOCAELİSPOR (20 Players)
# =============================================================================
KOCAELISPOR = {
    "id": "koc", "name": "Kocaelispor", "short_name": "KOC",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/f6erki1626445224.png",
    "stadium": "Kocaeli Stadyumu", "stadium_capacity": 33000, "coach": "Ertuğrul Sağlam",
    "colors": {"primary": "#00843D", "secondary": "#000000"},
    "overall_rating": 71, "attack_rating": 72, "midfield_rating": 72, "defense_rating": 70,
    "form": ["L", "L", "D", "L", "L"],
    "players": [
        p("koc_1", "Emre Orlan", "GK", 1, "Turkey", 28, 72, 38, 68, 72, 12, 45, 24, 16, 46, 70, 74, 72, val=0.5),
        p("koc_23", "Ferhat Kaplan", "GK", 23, "Turkey", 30, 71, 38, 68, 72, 12, 45, 24, 16, 46, 70, 73, 71, val=0.3),
        p("koc_4", "Taha Altıkardeş", "CB", 4, "Turkey", 26, 73, 68, 76, 78, 28, 50, 45, 75, 48, 72, val=1.5),
        p("koc_5", "Oğuz Ceylan", "CB", 5, "Turkey", 31, 72, 65, 74, 80, 28, 48, 42, 74, 46, 73, val=0.8),
        p("koc_3", "Ahmet Oğuz", "CB", 3, "Turkey", 32, 72, 65, 72, 80, 28, 50, 45, 75, 50, 74, val=0.5),
        p("koc_2", "Muhammed Gönülaçar", "RB", 2, "Turkey", 27, 72, 80, 78, 70, 50, 62, 68, 72, 55, 68, val=0.8),
        p("koc_22", "Şener Özbayraklı", "LB", 22, "Turkey", 36, 71, 72, 68, 68, 50, 65, 68, 74, 62, 75, val=0.3),
        p("koc_6", "Sedat Ağçay", "CDM", 6, "Turkey", 33, 72, 68, 75, 75, 55, 68, 65, 75, 65, 74, val=0.5),
        p("koc_8", "Atalay Babacan", "CM", 8, "Turkey", 28, 73, 75, 78, 70, 62, 70, 70, 62, 68, 72, val=1.0),
        p("koc_10", "Emre Çolak", "CAM", 10, "Turkey", 35, 74, 65, 72, 65, 72, 78, 76, 32, 78, 76, key=True, val=0.8),
        p("koc_14", "Onur Atasayar", "CM", 14, "Turkey", 32, 72, 72, 76, 70, 62, 70, 70, 58, 68, 72, val=0.5),
        p("koc_18", "İsmail Aissati", "CAM", 18, "Morocco", 35, 72, 65, 68, 62, 68, 75, 74, 35, 76, 74, val=0.3),
        p("koc_7", "Berkan Emir", "RW", 7, "Turkey", 26, 73, 85, 78, 65, 70, 62, 76, 25, 58, 68, val=1.0),
        p("koc_9", "Muhammet Demir", "ST", 9, "Turkey", 29, 74, 78, 78, 78, 76, 52, 70, 25, 58, 73, key=True, val=2.0),
        p("koc_11", "Rachid Ghezzal", "RW", 11, "Algeria", 32, 75, 82, 75, 65, 75, 78, 82, 28, 76, 74, key=True, val=2.0),
        p("koc_17", "Adem Büyük", "ST", 17, "Turkey", 37, 72, 65, 68, 78, 74, 52, 65, 28, 62, 76, val=0.3),
        p("koc_19", "Yusuf Çelik", "LW", 19, "Turkey", 25, 72, 85, 76, 65, 68, 58, 76, 25, 58, 68, val=0.8),
        p("koc_20", "Halil Akbunar", "LM", 20, "Turkey", 33, 72, 78, 72, 62, 68, 70, 74, 38, 72, 74, val=0.5),
        p("koc_21", "Süleyman Luş", "CM", 21, "Turkey", 29, 72, 72, 76, 70, 60, 68, 68, 55, 65, 70, val=0.5),
        p("koc_25", "Ferhat Öztorun", "ST", 25, "Turkey", 30, 73, 78, 76, 75, 74, 52, 70, 25, 55, 72, val=1.0),
    ]
}

# =============================================================================
# GAZİANTEP FK (20 Players)
# =============================================================================
GAZIANTEP = {
    "id": "gaz", "name": "Gaziantep FK", "short_name": "GAZ",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/54j6ik1579458093.png",
    "stadium": "Gaziantep Stadyumu", "stadium_capacity": 35564, "coach": "Marius Şumudică",
    "colors": {"primary": "#E4002B", "secondary": "#000000"},
    "overall_rating": 72, "attack_rating": 73, "midfield_rating": 73, "defense_rating": 71,
    "form": ["L", "L", "L", "D", "L"],
    "players": [
        p("gaz_1", "Beto", "GK", 1, "Portugal", 43, 72, 35, 62, 74, 12, 48, 24, 16, 50, 75, 74, 73, val=0.3),
        p("gaz_23", "Onurcan Piri", "GK", 23, "Turkey", 26, 72, 40, 68, 74, 14, 48, 26, 16, 48, 72, 74, 72, val=0.5),
        p("gaz_4", "Papy Djilobodji", "CB", 4, "Senegal", 37, 73, 62, 68, 85, 28, 48, 40, 75, 46, 74, val=0.3),
        p("gaz_5", "Kevin Varga", "CB", 5, "Hungary", 28, 74, 70, 78, 80, 30, 52, 48, 77, 50, 72, val=2.0),
        p("gaz_3", "Alpaslan Öztürk", "CB", 3, "Turkey", 31, 74, 68, 76, 82, 30, 52, 48, 77, 50, 74, val=2.0),
        p("gaz_2", "Junior Morais", "RB", 2, "Brazil", 37, 72, 75, 68, 68, 52, 68, 70, 74, 65, 75, val=0.3),
        p("gaz_22", "Sergio Escudero", "LB", 22, "Spain", 35, 73, 78, 72, 70, 52, 68, 72, 76, 65, 75, val=0.5),
        p("gaz_6", "Luckassen", "CDM", 6, "Netherlands", 28, 74, 70, 80, 80, 55, 65, 62, 78, 60, 72, val=2.0),
        p("gaz_8", "Alexandru Maxim", "CAM", 8, "Romania", 35, 75, 70, 72, 68, 75, 78, 76, 35, 78, 76, key=True, val=1.0),
        p("gaz_10", "Mirallas", "CAM", 10, "Belgium", 37, 73, 72, 68, 62, 72, 76, 78, 28, 76, 76, val=0.3),
        p("gaz_14", "Thijs Oosting", "CM", 14, "Netherlands", 27, 74, 78, 80, 72, 68, 72, 72, 58, 70, 72, val=2.0),
        p("gaz_18", "Furkan Soyalp", "RB", 18, "Turkey", 30, 72, 80, 78, 70, 50, 62, 68, 73, 55, 70, val=0.8),
        p("gaz_7", "Paulos Abraham", "RW", 7, "Sweden", 24, 74, 88, 78, 68, 72, 62, 80, 25, 62, 68, val=2.5),
        p("gaz_9", "Muhammet Demir", "ST", 9, "Turkey", 29, 74, 78, 78, 78, 75, 52, 68, 22, 55, 72, key=True, val=2.0),
        p("gaz_11", "Nicolae Stanciu", "CAM", 11, "Romania", 32, 75, 72, 75, 68, 78, 80, 78, 35, 80, 78, key=True, val=3.0),
        p("gaz_17", "Claudiu Keşerü", "ST", 17, "Romania", 38, 72, 62, 65, 78, 74, 50, 62, 28, 60, 78, val=0.3),
        p("gaz_19", "Kevin Mirallas", "LW", 19, "Belgium", 37, 72, 72, 68, 62, 70, 72, 76, 28, 72, 75, val=0.3),
        p("gaz_20", "Oğuzhan Aydoğan", "CM", 20, "Turkey", 27, 72, 75, 78, 68, 62, 68, 70, 55, 65, 70, val=0.8),
        p("gaz_21", "Güven Yalçın", "ST", 21, "Turkey", 25, 74, 82, 78, 72, 76, 55, 74, 25, 58, 72, val=2.5),
        p("gaz_25", "Ahmed Ildız", "CM", 25, "Turkey", 28, 72, 75, 78, 70, 60, 68, 68, 55, 65, 70, val=0.8),
    ]
}

# =============================================================================
# ALANYASPOR (24 Players)
# =============================================================================
ALANYASPOR = {
    "id": "aln", "name": "Alanyaspor", "short_name": "ALN",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/9fr3071601667898.png",
    "stadium": "Haydar Aliyev Stadyumu", "stadium_capacity": 10842, "coach": "C. João Pereira",
    "colors": {"primary": "#FF6600", "secondary": "#00843D"},
    "overall_rating": 73, "attack_rating": 74, "midfield_rating": 73, "defense_rating": 72,
    "form": ["D", "W", "D", "L", "W"],
    "players": [
        p("aln_1", "Paulo Victor", "GK", 1, "Brazil", 34, 74, 40, 68, 76, 16, 52, 30, 20, 52, 74, 76, 74, val=1.0),
        p("aln_23", "Ertuğrul Taşkıran", "GK", 23, "Turkey", 30, 73, 40, 68, 74, 14, 48, 28, 18, 50, 72, 75, 73, val=0.8),
        p("aln_4", "Bruno Viana", "CB", 4, "Brazil", 30, 75, 72, 76, 82, 32, 55, 50, 78, 52, 74, key=True, val=3.0),
        p("aln_5", "Fidan Aliti", "CB", 5, "Slovenia", 29, 75, 70, 78, 82, 30, 52, 48, 78, 50, 74, val=2.5),
        p("aln_3", "Fatih Aksoy", "CB", 3, "Turkey", 27, 74, 70, 76, 80, 32, 55, 50, 77, 52, 73, val=2.0),
        p("aln_2", "Florent Hadergjonaj", "RB", 2, "Kosovo", 30, 75, 82, 80, 72, 52, 68, 72, 74, 62, 72, val=2.0),
        p("aln_22", "Nuno Lima", "LB", 22, "Portugal", 29, 74, 80, 78, 72, 52, 68, 72, 75, 62, 73, val=2.0),
        p("aln_6", "Gaius Makouta", "CDM", 6, "Congo", 27, 75, 72, 82, 78, 58, 70, 68, 78, 65, 72, key=True, val=3.0),
        p("aln_8", "Ianis Hagi", "CAM", 8, "Romania", 26, 77, 78, 78, 68, 75, 80, 82, 32, 82, 76, key=True, val=8.0),
        p("aln_10", "Efecan Karaca", "CM", 10, "Turkey", 31, 75, 75, 80, 72, 68, 75, 74, 52, 72, 74, key=True, val=2.0),
        p("aln_14", "Nicolas Janvier", "CM", 14, "France", 27, 74, 78, 78, 70, 68, 74, 74, 55, 72, 73, val=2.0),
        p("aln_18", "İbrahim Kaya", "LM", 18, "Turkey", 28, 73, 82, 78, 68, 68, 65, 76, 32, 65, 70, val=1.5),
        p("aln_7", "Meschack Elia", "RW", 7, "DR Congo", 27, 76, 92, 78, 70, 76, 62, 84, 25, 62, 70, key=True, val=5.0),
        p("aln_9", "Steve Mounié", "ST", 9, "Benin", 30, 75, 78, 78, 85, 78, 52, 68, 28, 55, 74, key=True, val=3.0),
        p("aln_11", "Ui-Jo Hwang", "ST", 11, "South Korea", 33, 76, 85, 78, 78, 78, 58, 76, 28, 62, 76, key=True, val=4.0),
        p("aln_17", "Ruan", "LW", 17, "Brazil", 26, 75, 88, 78, 70, 74, 62, 80, 25, 62, 70, val=3.0),
        p("aln_19", "Güven Yalçın", "ST", 19, "Turkey", 25, 74, 82, 78, 72, 76, 55, 74, 25, 58, 72, val=2.5),
        p("aln_20", "Enes Keskin", "CM", 20, "Turkey", 23, 72, 78, 78, 68, 62, 70, 70, 55, 65, 70, val=1.0),
        p("aln_21", "Uchenna Ogundu", "ST", 21, "Nigeria", 23, 73, 85, 78, 75, 74, 52, 74, 22, 55, 68, val=1.5),
        p("aln_25", "Baran Mogultay", "RB", 25, "Turkey", 24, 72, 80, 78, 70, 50, 62, 68, 73, 55, 68, val=0.8),
        p("aln_27", "Batuhan Yavuz", "CB", 27, "Turkey", 25, 73, 68, 76, 80, 28, 50, 45, 76, 48, 71, val=1.0),
        p("aln_28", "Ümit Akdağ", "CB", 28, "Turkey", 30, 73, 68, 76, 80, 28, 50, 45, 77, 50, 74, val=1.0),
        p("aln_30", "Emirhan Çavuş", "CAM", 30, "Turkey", 22, 72, 78, 78, 65, 68, 72, 74, 32, 68, 68, val=1.0),
        p("aln_33", "Yusuf Can Karademir", "CM", 33, "Turkey", 22, 71, 75, 78, 68, 58, 65, 68, 55, 62, 68, val=0.5),
    ]
}

# =============================================================================
# BAŞAKŞEHIR (26 Players)
# =============================================================================
BASAKSEHIR = {
    "id": "bas", "name": "Başakşehir", "short_name": "BAS",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/895mqt1685993958.png",
    "stadium": "Başakşehir Fatih Terim Stadyumu", "stadium_capacity": 17319, "coach": "Nuri Şahin",
    "colors": {"primary": "#FF6600", "secondary": "#1C3B6E"},
    "overall_rating": 75, "attack_rating": 75, "midfield_rating": 75, "defense_rating": 75,
    "form": ["W", "D", "W", "D", "W"],
    "players": [
        p("bas_1", "Volkan Babacan", "GK", 1, "Turkey", 38, 76, 38, 65, 78, 15, 52, 28, 18, 55, 78, 78, 77, key=True, val=0.5),
        p("bas_23", "Muhammed Şengezer", "GK", 23, "Turkey", 24, 73, 40, 68, 74, 14, 48, 28, 18, 50, 72, 75, 73, val=0.8),
        p("bas_4", "Léo Duarte", "CB", 4, "Brazil", 28, 77, 72, 78, 82, 32, 55, 50, 79, 52, 75, key=True, val=4.0),
        p("bas_5", "Jerome Opoku", "CB", 5, "Ghana", 26, 75, 72, 78, 82, 30, 52, 48, 78, 50, 73, val=2.5),
        p("bas_3", "Ousseynou Ba", "CB", 3, "Senegal", 30, 75, 70, 78, 84, 30, 52, 48, 78, 50, 74, val=2.0),
        p("bas_2", "Christopher Operi", "RB", 2, "Belgium", 24, 74, 85, 80, 72, 52, 68, 72, 75, 62, 70, val=2.0),
        p("bas_22", "Festy Ebosele", "LB", 22, "Ireland", 22, 75, 88, 82, 72, 58, 68, 75, 72, 65, 70, val=4.0),
        p("bas_6", "Miguel Crespo", "CDM", 6, "Portugal", 30, 76, 70, 80, 78, 62, 75, 72, 78, 72, 76, key=True, val=3.0),
        p("bas_8", "Amine Harit", "CAM", 8, "Morocco", 28, 78, 78, 78, 68, 76, 82, 84, 32, 82, 75, key=True, val=8.0),
        p("bas_10", "Ömer Beyaz", "CAM", 10, "Turkey", 21, 75, 78, 78, 65, 72, 78, 80, 32, 76, 72, val=5.0),
        p("bas_14", "Jakub Kaluzinski", "CM", 14, "Poland", 23, 74, 78, 80, 72, 65, 72, 72, 62, 70, 72, val=3.0),
        p("bas_18", "Deniz Türüç", "RM", 18, "Turkey", 32, 76, 80, 78, 68, 76, 75, 80, 38, 76, 76, val=3.0),
        p("bas_7", "Davie Selke", "ST", 7, "Germany", 30, 76, 78, 78, 82, 78, 55, 72, 28, 58, 76, key=True, val=4.0),
        p("bas_9", "Eldor Şomurodov", "ST", 9, "Uzbekistan", 30, 77, 82, 78, 80, 78, 58, 76, 28, 62, 76, key=True, val=6.0),
        p("bas_11", "Abbosbek Fayzullaev", "LW", 11, "Uzbekistan", 22, 76, 88, 78, 68, 76, 65, 82, 28, 68, 70, val=5.0),
        p("bas_17", "Nuno Da Costa", "ST", 17, "Cape Verde", 33, 74, 78, 76, 75, 75, 55, 72, 28, 58, 74, val=2.0),
        p("bas_19", "Yusuf Sarı", "LW", 19, "Turkey", 26, 75, 85, 78, 68, 72, 65, 78, 28, 65, 72, val=3.0),
        p("bas_20", "Onur Bulut", "RB", 20, "Turkey", 30, 74, 82, 78, 72, 55, 68, 72, 75, 62, 73, val=1.5),
        p("bas_21", "Hamza Güreler", "LB", 21, "Turkey", 25, 73, 80, 78, 70, 52, 65, 68, 74, 58, 70, val=1.0),
        p("bas_25", "Berat Ayberk Özdemir", "CM", 25, "Turkey", 28, 74, 75, 78, 72, 65, 72, 72, 62, 70, 74, val=1.5),
        p("bas_27", "Ömer Ali Şahiner", "CB", 27, "Turkey", 32, 74, 68, 76, 82, 30, 52, 48, 77, 52, 76, val=1.0),
        p("bas_28", "Olivier Kemen", "CM", 28, "France", 28, 74, 75, 80, 78, 60, 70, 70, 68, 65, 72, val=2.0),
        p("bas_30", "Tuğra Turhan", "ST", 30, "Turkey", 20, 72, 82, 76, 70, 72, 52, 74, 22, 55, 68, val=1.0),
        p("bas_33", "Ivan Brnic", "ST", 33, "Croatia", 26, 74, 80, 78, 78, 75, 52, 72, 25, 55, 72, val=2.0),
        p("bas_35", "Umut Güneş", "CM", 35, "Turkey", 24, 72, 75, 78, 70, 60, 68, 70, 55, 65, 70, val=0.8),
        p("bas_99", "Matchoi Djalo", "RW", 99, "Guinea-Bissau", 21, 73, 88, 76, 68, 72, 62, 80, 25, 62, 68, val=2.0),
    ]
}

# =============================================================================
# KAYSERİSPOR (22 Players)
# =============================================================================
KAYSERISPOR = {
    "id": "kay", "name": "Kayserispor", "short_name": "KAY",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/bvskgi1601668985.png",
    "stadium": "RHG Enertürk Enerji Stadyumu", "stadium_capacity": 32864, "coach": "Burak Yılmaz",
    "colors": {"primary": "#FFFF00", "secondary": "#E4002B"},
    "overall_rating": 72, "attack_rating": 73, "midfield_rating": 72, "defense_rating": 71,
    "form": ["L", "D", "L", "L", "D"],
    "players": [
        p("kay_1", "Bilal Bayazıt", "GK", 1, "Turkey", 28, 73, 40, 70, 74, 14, 48, 26, 16, 48, 72, 75, 73, val=1.0),
        p("kay_23", "Berke Kapacık", "GK", 23, "Turkey", 23, 71, 40, 68, 72, 14, 46, 26, 16, 48, 70, 73, 71, val=0.5),
        p("kay_4", "Uğur Demirok", "CB", 4, "Turkey", 36, 74, 62, 70, 80, 30, 52, 42, 76, 50, 76, val=0.5),
        p("kay_5", "Dimitris Giannoulis", "CB", 5, "Greece", 29, 75, 78, 78, 80, 30, 55, 52, 77, 52, 73, val=3.0),
        p("kay_3", "Gustavo Campanharo", "CB", 3, "Brazil", 32, 74, 68, 76, 82, 30, 52, 48, 77, 50, 74, val=1.5),
        p("kay_2", "Yasin Pehlivan", "RB", 2, "Turkey", 33, 73, 78, 75, 70, 52, 68, 70, 75, 62, 75, val=0.5),
        p("kay_22", "Uğur Çiftçi", "LB", 22, "Turkey", 30, 73, 78, 78, 70, 52, 65, 70, 75, 60, 73, val=1.0),
        p("kay_6", "Hasan Kılıç", "CDM", 6, "Turkey", 28, 73, 70, 78, 78, 55, 68, 65, 76, 62, 72, val=1.0),
        p("kay_8", "Gabriel Torje", "CAM", 8, "Romania", 36, 74, 68, 70, 68, 72, 76, 74, 42, 75, 75, key=True, val=0.5),
        p("kay_10", "Pedro Henrique", "CAM", 10, "Brazil", 33, 75, 72, 75, 68, 76, 80, 80, 32, 80, 78, key=True, val=1.5),
        p("kay_14", "Emrah Başsan", "CM", 14, "Turkey", 34, 73, 70, 75, 72, 62, 72, 70, 62, 72, 75, val=0.5),
        p("kay_18", "Mame Thiam", "CM", 18, "Senegal", 32, 74, 75, 80, 78, 62, 70, 70, 68, 68, 74, val=1.5),
        p("kay_7", "Bruno Paz", "RW", 7, "Portugal", 25, 74, 85, 78, 68, 72, 68, 80, 28, 68, 72, val=2.5),
        p("kay_9", "Mario Gavranović", "ST", 9, "Switzerland", 35, 74, 75, 72, 75, 76, 58, 72, 22, 62, 76, key=True, val=0.8),
        p("kay_11", "Zoubir", "LW", 11, "Algeria", 31, 74, 85, 76, 68, 72, 65, 80, 28, 68, 73, val=2.0),
        p("kay_17", "Olivier Kemen", "CM", 17, "France", 28, 74, 75, 80, 78, 60, 70, 70, 68, 65, 72, val=2.0),
        p("kay_19", "Onur Bulut", "RB", 19, "Turkey", 30, 73, 80, 78, 70, 52, 65, 70, 74, 58, 72, val=1.0),
        p("kay_20", "İlhan Parlak", "LW", 20, "Turkey", 36, 72, 75, 68, 62, 68, 70, 74, 28, 72, 75, val=0.3),
        p("kay_21", "Joseph Attamah", "CB", 21, "Ghana", 31, 73, 72, 76, 82, 28, 50, 48, 76, 48, 73, val=1.0),
        p("kay_25", "Emre Demir", "CAM", 25, "Turkey", 21, 73, 78, 78, 65, 70, 74, 76, 32, 72, 70, val=3.0),
        p("kay_27", "Ramazan Özcan", "CM", 27, "Turkey", 25, 72, 75, 78, 70, 60, 68, 70, 55, 65, 70, val=0.8),
        p("kay_30", "Yusuf Can Esendemir", "ST", 30, "Turkey", 23, 72, 82, 76, 70, 72, 52, 74, 22, 55, 68, val=1.0),
    ]
}

# =============================================================================
# FATİH KARAGÜMRÜK (22 Players)
# =============================================================================
FATIH_KARAGUMRUK = {
    "id": "fkg", "name": "Fatih Karagümrük", "short_name": "FKG",
    "badge_url": "https://r2.thesportsdb.com/images/media/team/badge/bfb84y1580847945.png",
    "stadium": "Atatürk Olimpiyat Stadyumu", "stadium_capacity": 76092, "coach": "Tolunay Kafkas",
    "colors": {"primary": "#8B0000", "secondary": "#FFFFFF"},
    "overall_rating": 73, "attack_rating": 74, "midfield_rating": 73, "defense_rating": 72,
    "form": ["L", "L", "D", "W", "L"],
    "players": [
        p("fkg_1", "Fatih Öztürk", "GK", 1, "Turkey", 39, 73, 35, 65, 74, 12, 48, 25, 16, 50, 75, 75, 74, val=0.3),
        p("fkg_23", "Serdar Azmı", "GK", 23, "Turkey", 27, 72, 40, 68, 74, 14, 48, 26, 16, 48, 72, 74, 72, val=0.5),
        p("fkg_4", "Lucas Biglia", "CB", 4, "Argentina", 39, 74, 58, 68, 75, 45, 78, 68, 76, 78, 80, key=True, val=0.3),
        p("fkg_5", "Kerem Kesgin", "CB", 5, "Turkey", 27, 74, 68, 76, 80, 28, 52, 48, 76, 50, 72, val=1.5),
        p("fkg_3", "Marlon", "CB", 3, "Brazil", 30, 75, 72, 78, 82, 32, 55, 50, 78, 52, 74, val=2.5),
        p("fkg_2", "Eren Elmalı", "RB", 2, "Turkey", 24, 74, 82, 80, 70, 52, 68, 72, 74, 62, 72, val=2.5),
        p("fkg_22", "Oğuz Kağan Güçtekin", "LB", 22, "Turkey", 27, 73, 80, 78, 70, 50, 65, 70, 74, 58, 71, val=1.0),
        p("fkg_6", "Mert Hakan Yandaş", "CDM", 6, "Turkey", 31, 75, 70, 78, 75, 62, 74, 70, 76, 70, 76, key=True, val=2.5),
        p("fkg_8", "Andrea Bertolacci", "CM", 8, "Italy", 33, 74, 68, 72, 72, 72, 76, 75, 48, 75, 75, key=True, val=0.5),
        p("fkg_10", "Emre Mor", "LW", 10, "Turkey", 27, 76, 92, 75, 58, 72, 70, 85, 22, 68, 68, key=True, val=3.0),
        p("fkg_14", "Borini", "RM", 14, "Italy", 34, 74, 78, 72, 68, 72, 72, 78, 38, 72, 75, val=0.5),
        p("fkg_18", "Oğuz Aydın", "CAM", 18, "Turkey", 25, 75, 82, 78, 68, 72, 76, 78, 35, 74, 73, val=3.0),
        p("fkg_7", "Ahmed Hassan", "RW", 7, "Egypt", 29, 75, 85, 78, 68, 74, 70, 82, 28, 68, 72, key=True, val=3.0),
        p("fkg_9", "Yasin Öztekin", "ST", 9, "Turkey", 38, 72, 72, 65, 62, 70, 70, 74, 28, 72, 75, val=0.3),
        p("fkg_11", "Papiss Cissé", "ST", 11, "Senegal", 40, 72, 62, 62, 78, 75, 50, 62, 28, 58, 78, val=0.3),
        p("fkg_17", "Alassane Ndao", "LW", 17, "Senegal", 27, 75, 88, 80, 70, 74, 62, 78, 28, 62, 72, val=3.0),
        p("fkg_19", "Ertuğrul Ersoy", "CB", 19, "Turkey", 29, 74, 68, 76, 82, 28, 52, 48, 77, 50, 73, val=2.0),
        p("fkg_20", "Fabio Borini", "ST", 20, "Italy", 34, 74, 78, 72, 72, 75, 68, 76, 32, 72, 76, val=0.5),
        p("fkg_21", "Kerim Frei", "CAM", 21, "Turkey", 32, 73, 78, 72, 62, 70, 75, 78, 32, 76, 74, val=0.5),
        p("fkg_25", "Adem Ljajic", "CAM", 25, "Serbia", 33, 75, 72, 72, 65, 75, 80, 80, 28, 82, 76, val=1.0),
        p("fkg_27", "Yusuf Demir", "RW", 27, "Austria", 22, 74, 82, 78, 65, 72, 75, 80, 28, 72, 70, val=3.0),
        p("fkg_30", "Salih Kavrazlı", "CM", 30, "Turkey", 25, 72, 75, 78, 70, 60, 68, 70, 55, 65, 70, val=0.8),
    ]
}

# =============================================================================
# EXPORT
# =============================================================================
ANADOLU_PART2 = {
    "goz": GOZTEPE,
    "koc": KOCAELISPOR,
    "gaz": GAZIANTEP,
    "aln": ALANYASPOR,
    "bas": BASAKSEHIR,
    "kay": KAYSERISPOR,
    "fkg": FATIH_KARAGUMRUK,
}
