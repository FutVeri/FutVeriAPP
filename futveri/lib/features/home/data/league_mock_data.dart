/// Mock data for league system
/// This provides static data for development, will be replaced with Supabase in production

import 'league_models.dart';

/// Turkish names for mock league members
const _mockNames = [
  'Emre Yılmaz',
  'Ahmet Demir',
  'Mehmet Kaya',
  'Mustafa Çelik',
  'Ali Şahin',
  'Hasan Yıldız',
  'Hüseyin Öztürk',
  'İbrahim Arslan',
  'Fatih Doğan',
  'Burak Korkmaz',
  'Cem Aydın',
  'Deniz Güneş',
  'Efe Koç',
  'Gökhan Özkan',
  'Halil Polat',
  'İsmail Tekin',
  'Kadir Yalçın',
  'Kerem Erdoğan',
  'Mert Karaca',
  'Oğuz Aksoy',
  'Onur Çetin',
  'Ömer Kaplan',
  'Serkan Ay',
  'Tolga Kılıç',
  'Uğur Demirci',
  'Volkan Aslan',
  'Yusuf Taş',
  'Zafer Kurt',
  'Berk Tunç',
  'Can Bayrak',
];

/// Generate mock league data for the current month
League getMockLeague() {
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
  
  // Turkish month names
  const monthNames = [
    'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
    'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
  ];
  
  final period = '${monthNames[now.month - 1]} ${now.year}';
  
  // Generate 30 members with decreasing points
  final members = List.generate(30, (index) {
    final basePoints = 2500 - (index * 70) + (index < 3 ? 200 : 0);
    final points = basePoints + (index.hashCode % 50);
    final reportCount = 50 - index + (index.hashCode % 10);
    
    // Add badges for some members (simulating past achievements)
    final badges = <LeagueBadge>[];
    if (index == 0) {
      // Previous gold winner
      badges.add(LeagueBadge(
        id: 'badge_${index}_1',
        type: LeagueBadgeType.gold,
        earnedAt: DateTime(now.year, now.month - 1, 28),
        leaguePeriod: '${monthNames[(now.month - 2) % 12]} ${now.month == 1 ? now.year - 1 : now.year}',
      ));
    } else if (index == 2) {
      // Previous silver winner
      badges.add(LeagueBadge(
        id: 'badge_${index}_1',
        type: LeagueBadgeType.silver,
        earnedAt: DateTime(now.year, now.month - 2, 28),
        leaguePeriod: '${monthNames[(now.month - 3) % 12]} ${now.month <= 2 ? now.year - 1 : now.year}',
      ));
    } else if (index == 4) {
      // Previous bronze winner
      badges.add(LeagueBadge(
        id: 'badge_${index}_1',
        type: LeagueBadgeType.bronze,
        earnedAt: DateTime(now.year, now.month - 1, 28),
        leaguePeriod: '${monthNames[(now.month - 2) % 12]} ${now.month == 1 ? now.year - 1 : now.year}',
      ));
    }
    
    return LeagueMember(
      id: 'member_$index',
      name: _mockNames[index],
      rank: index + 1,
      points: points,
      reportCount: reportCount,
      badges: badges,
      isCurrentUser: index == 7, // Mark 8th place as current user for demo
    );
  });
  
  return League(
    id: 'league_${now.year}_${now.month}',
    name: '$period Ligi',
    period: period,
    startDate: startOfMonth,
    endDate: endOfMonth,
    members: members,
  );
}

/// Get mock badges for a specific user (for profile display)
List<LeagueBadge> getMockUserBadges(String userId) {
  // For demo, return some badges for the "current user"
  final now = DateTime.now();
  const monthNames = [
    'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
    'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
  ];
  
  return [
    LeagueBadge(
      id: 'user_badge_1',
      type: LeagueBadgeType.gold,
      earnedAt: DateTime(now.year, now.month - 3, 28),
      leaguePeriod: '${monthNames[(now.month - 4) % 12]} ${now.month <= 3 ? now.year - 1 : now.year}',
    ),
    LeagueBadge(
      id: 'user_badge_2',
      type: LeagueBadgeType.silver,
      earnedAt: DateTime(now.year, now.month - 2, 28),
      leaguePeriod: '${monthNames[(now.month - 3) % 12]} ${now.month <= 2 ? now.year - 1 : now.year}',
    ),
    LeagueBadge(
      id: 'user_badge_3',
      type: LeagueBadgeType.bronze,
      earnedAt: DateTime(now.year, now.month - 1, 28),
      leaguePeriod: '${monthNames[(now.month - 2) % 12]} ${now.month == 1 ? now.year - 1 : now.year}',
    ),
  ];
}

/// Get current user's league member info (for profile)
LeagueMember? getCurrentUserLeagueMember() {
  final league = getMockLeague();
  return league.members.where((m) => m.isCurrentUser).firstOrNull;
}
