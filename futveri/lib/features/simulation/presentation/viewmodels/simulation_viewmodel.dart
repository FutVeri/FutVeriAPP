import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedWeekNotifier extends Notifier<int> {
  @override
  int build() => 18;

  void setWeek(int week) {
    state = week;
  }

  void increment() {
    if (state < 34) state++;
  }

  void decrement() {
    if (state > 1) state--;
  }
}

final selectedWeekProvider = NotifierProvider<SelectedWeekNotifier, int>(() {
  return SelectedWeekNotifier();
});
