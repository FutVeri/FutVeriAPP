import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/features/home/domain/player_search_result.dart';

// State for the Home Page
class HomeState {
  final String searchQuery;
  final List<PlayerSearchResult> searchResults;
  final bool isSearching;

  HomeState({
    this.searchQuery = '',
    this.searchResults = const [],
    this.isSearching = false,
  });

  HomeState copyWith({
    String? searchQuery,
    List<PlayerSearchResult>? searchResults,
    bool? isSearching,
  }) {
    return HomeState(
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState();
  }

  // Mock player database
  final List<PlayerSearchResult> _allPlayers = [
    PlayerSearchResult(
      id: '1',
      name: 'Arda Güler',
      position: 'CAM',
      age: 19,
      team: 'Real Madrid',
    ),
    PlayerSearchResult(
      id: '2',
      name: 'Kenan Yıldız',
      position: 'LW',
      age: 19,
      team: 'Juventus',
    ),
    PlayerSearchResult(
      id: '3',
      name: 'Semih Kılıçsoy',
      position: 'ST',
      age: 18,
      team: 'Beşiktaş',
    ),
    PlayerSearchResult(
      id: '4',
      name: 'Can Uzun',
      position: 'ST',
      age: 18,
      team: 'Eintracht Frankfurt',
    ),
    PlayerSearchResult(
      id: '5',
      name: 'Metehan Baltacı',
      position: 'CB',
      age: 19,
      team: 'Beşiktaş',
    ),
    PlayerSearchResult(
      id: '6',
      name: 'Emir Han Topçu',
      position: 'CM',
      age: 18,
      team: 'Galatasaray',
    ),
    PlayerSearchResult(
      id: '7',
      name: 'Bertuğ Yıldırım',
      position: 'ST',
      age: 21,
      team: 'Rennes',
    ),
    PlayerSearchResult(
      id: '8',
      name: 'Salih Özcan',
      position: 'CDM',
      age: 26,
      team: 'Borussia Dortmund',
    ),
  ];

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query, isSearching: true);
    performSearch();
  }

  void performSearch() {
    if (state.searchQuery.isEmpty) {
      state = state.copyWith(searchResults: [], isSearching: false);
      return;
    }

    final query = state.searchQuery.toLowerCase();
    final results = _allPlayers.where((player) {
      return player.name.toLowerCase().contains(query) ||
          player.position.toLowerCase().contains(query) ||
          player.team.toLowerCase().contains(query);
    }).toList();

    state = state.copyWith(searchResults: results, isSearching: false);
  }

  void clearSearch() {
    state = HomeState();
  }
}

final homeProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
