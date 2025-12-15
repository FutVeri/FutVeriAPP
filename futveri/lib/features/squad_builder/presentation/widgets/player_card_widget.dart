import 'package:flutter/material.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/entities/position.dart';

/// FIFA-style player card widget
class PlayerCardWidget extends StatelessWidget {
  final PlayerEntity player;
  final Position? displayPosition;
  final VoidCallback? onTap;
  final bool isCompact;
  final bool isDraggable;

  const PlayerCardWidget({
    super.key,
    required this.player,
    this.displayPosition,
    this.onTap,
    this.isCompact = false,
    this.isDraggable = false,
  });

  @override
  Widget build(BuildContext context) {
    final rating = displayPosition != null
        ? player.getRatingForPosition(displayPosition!)
        : player.overallRating;

    final card = GestureDetector(
      onTap: onTap,
      child: Container(
        width: isCompact ? 80 : 120,
        height: isCompact ? 100 : 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _getRatingColor(rating).withOpacity(0.9),
              _getRatingColor(rating).withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Rating badge
            Positioned(
              top: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isCompact ? 20 : 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    (displayPosition ?? player.primaryPosition).code,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isCompact ? 10 : 12,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Player name
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    player.name.split(' ').last,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isCompact ? 10 : 12,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!isCompact) ...[
                    const SizedBox(height: 2),
                    Text(
                      player.nationality,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 10,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Nationality flag (top right)
            if (!isCompact)
              Positioned(
                top: 8,
                right: 8,
                child: Text(
                  player.nationality.split(' ').first,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );

    if (isDraggable) {
      return Draggable<PlayerEntity>(
        data: player,
        feedback: Opacity(
          opacity: 0.8,
          child: card,
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: card,
        ),
        child: card,
      );
    }

    return card;
  }

  Color _getRatingColor(int rating) {
    if (rating >= 85) return const Color(0xFF00D9A3); // Elite - Green
    if (rating >= 80) return const Color(0xFF4CAF50); // Great - Light Green
    if (rating >= 75) return const Color(0xFFFFA502); // Good - Orange
    if (rating >= 70) return const Color(0xFFFF6B6B); // Average - Red
    return const Color(0xFF8B949E); // Below average - Gray
  }
}

/// Empty player slot widget
class EmptyPlayerSlot extends StatelessWidget {
  final Position position;
  final VoidCallback? onTap;

  const EmptyPlayerSlot({
    super.key,
    required this.position,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                color: Colors.white.withOpacity(0.5),
                size: 32,
              ),
              const SizedBox(height: 4),
              Text(
                position.code,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
