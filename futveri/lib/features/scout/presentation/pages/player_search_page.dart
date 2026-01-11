import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';

class PlayerSearchPage extends StatefulWidget {
  const PlayerSearchPage({super.key});

  @override
  State<PlayerSearchPage> createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allPlayers = [
    {'name': 'Mauro Icardi', 'team': 'Galatasaray', 'position': 'ST', 'age': 30},
    {'name': 'Edin Dzeko', 'team': 'Fenerbahçe', 'position': 'ST', 'age': 37},
    {'name': 'Vincent Aboubakar', 'team': 'Beşiktaş', 'position': 'ST', 'age': 31},
    {'name': 'Kerem Aktürkoğlu', 'team': 'Galatasaray', 'position': 'LW', 'age': 25},
    {'name': 'Ferdi Kadıoğlu', 'team': 'Fenerbahçe', 'position': 'LB', 'age': 24},
    {'name': 'Semih Kılıçsoy', 'team': 'Beşiktaş', 'position': 'ST', 'age': 18},
    {'name': 'Uğurcan Çakır', 'team': 'Trabzonspor', 'position': 'GK', 'age': 27},
  ];
  List<Map<String, dynamic>> _filteredPlayers = [];

  @override
  void initState() {
    super.initState();
    _filteredPlayers = _allPlayers;
  }

  void _filterPlayers(String query) {
    setState(() {
      _filteredPlayers = _allPlayers
          .where((player) =>
              player['name'].toLowerCase().contains(query.toLowerCase()) ||
              player['team'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyuncu Ara'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: _filterPlayers,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Oyuncu veya takım adı...',
                prefixIcon: const Icon(LucideIcons.search, color: AppTheme.textGrey),
                filled: true,
                fillColor: AppTheme.surfaceDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredPlayers.isEmpty
                ? const Center(child: Text('Oyuncu bulunamadı', style: TextStyle(color: AppTheme.textGrey)))
                : ListView.builder(
                    itemCount: _filteredPlayers.length,
                    itemBuilder: (context, index) {
                      final player = _filteredPlayers[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                          child: Text(player['position'], style: TextStyle(color: AppTheme.primaryGreen, fontSize: 10.sp)),
                        ),
                        title: Text(player['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('${player['team']} • ${player['age']} Yaş', style: const TextStyle(color: AppTheme.textGrey)),
                        trailing: const Icon(LucideIcons.chevronRight, color: AppTheme.textGrey),
                        onTap: () {
                          // TODO: Navigate to player profile or create report for this player
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
