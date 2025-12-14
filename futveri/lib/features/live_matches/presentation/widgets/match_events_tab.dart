import 'package:flutter/material.dart';
import '../../domain/entities/match_event_entity.dart';

/// Match events timeline tab
class MatchEventsTab extends StatelessWidget {
  final List<MatchEventEntity> events;

  const MatchEventsTab({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(
        child: Text('No events yet'),
      );
    }

    // Sort events by minute (descending - most recent first)
    final sortedEvents = List<MatchEventEntity>.from(events)
      ..sort((a, b) => b.minute.compareTo(a.minute));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedEvents.length,
      itemBuilder: (context, index) {
        final event = sortedEvents[index];
        return _EventItem(event: event);
      },
    );
  }
}

class _EventItem extends StatelessWidget {
  final MatchEventEntity event;

  const _EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Minute
          SizedBox(
            width: 50,
            child: Text(
              "${event.minute}'",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          
          // Icon
          _buildEventIcon(context),
          const SizedBox(width: 12),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getEventTitle(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (event.playerName != null)
                  Text(
                    event.playerName!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                if (event.description != null)
                  Text(
                    event.description!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventIcon(BuildContext context) {
    IconData icon;
    Color color;

    switch (event.type) {
      case MatchEventType.goal:
        icon = Icons.sports_soccer;
        color = Colors.green;
        break;
      case MatchEventType.yellowCard:
        icon = Icons.rectangle;
        color = Colors.yellow;
        break;
      case MatchEventType.redCard:
        icon = Icons.rectangle;
        color = Colors.red;
        break;
      case MatchEventType.substitution:
        icon = Icons.swap_horiz;
        color = Colors.blue;
        break;
      case MatchEventType.penalty:
        icon = Icons.sports_soccer;
        color = Colors.orange;
        break;
      case MatchEventType.ownGoal:
        icon = Icons.sports_soccer;
        color = Colors.red;
        break;
      case MatchEventType.varCheck:
        icon = Icons.videocam;
        color = Colors.purple;

        break;
    }

    return Icon(icon, color: color, size: 24);
  }

  String _getEventTitle() {
    switch (event.type) {
      case MatchEventType.goal:
        return 'Goal!';
      case MatchEventType.yellowCard:
        return 'Yellow Card';
      case MatchEventType.redCard:
        return 'Red Card';
      case MatchEventType.substitution:
        return 'Substitution';
      case MatchEventType.penalty:
        return 'Penalty Goal';
      case MatchEventType.ownGoal:
        return 'Own Goal';
      case MatchEventType.varCheck:
        return 'VAR Check';

    }
  }
}
