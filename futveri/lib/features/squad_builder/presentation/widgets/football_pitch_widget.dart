import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/formation_entity.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/position.dart';
import '../viewmodels/squad_builder_viewmodel.dart';
import 'player_card_widget.dart';

/// Football pitch widget with 3D effect
class FootballPitchWidget extends ConsumerWidget {
  const FootballPitchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(squadBuilderViewModelProvider);
    final viewModel = ref.read(squadBuilderViewModelProvider.notifier);

    return AspectRatio(
      aspectRatio: 0.7, // Football pitch ratio
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF2D5016), // Dark green
              const Color(0xFF3A6B1F), // Medium green
              const Color(0xFF2D5016), // Dark green
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Pitch lines
            CustomPaint(
              painter: PitchLinesPainter(),
              size: Size.infinite,
            ),

            // Player positions
            ...state.squad.formation.positions.map((pitchPosition) {
              final player = state.squad.getPlayerAt(pitchPosition.position);
              
              return Positioned(
                left: pitchPosition.x * MediaQuery.of(context).size.width * 0.7 - 40,
                top: pitchPosition.y * MediaQuery.of(context).size.width - 50,
                child: DragTarget<PlayerEntity>(
                  onAccept: (draggedPlayer) {
                    viewModel.setPlayerAtPosition(
                      pitchPosition.position,
                      draggedPlayer,
                    );
                  },
                  builder: (context, candidateData, rejectedData) {
                    final isHovering = candidateData.isNotEmpty;
                    
                    return AnimatedScale(
                      scale: isHovering ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: player != null
                          ? GestureDetector(
                              onLongPress: () {
                                viewModel.removePlayerFromPosition(
                                  pitchPosition.position,
                                );
                              },
                              child: PlayerCardWidget(
                                player: player,
                                displayPosition: pitchPosition.position,
                                isCompact: true,
                              ),
                            )
                          : EmptyPlayerSlot(
                              position: pitchPosition.position,
                            ),
                    );
                  },
                ),
              );
            }),

            // Formation name overlay
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  state.squad.formation.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Squad stats overlay
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${state.squad.filledPositions}/${state.squad.lineup.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFA502),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          state.squad.averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (state.squad.isComplete) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.flash_on,
                            color: Color(0xFF00D9A3),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${state.squad.chemistry}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for pitch lines
class PitchLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.15,
      paint,
    );

    // Center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Penalty areas
    final penaltyBoxWidth = size.width * 0.6;
    final penaltyBoxHeight = size.height * 0.15;

    // Top penalty area
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - penaltyBoxWidth) / 2,
        0,
        penaltyBoxWidth,
        penaltyBoxHeight,
      ),
      paint,
    );

    // Bottom penalty area
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - penaltyBoxWidth) / 2,
        size.height - penaltyBoxHeight,
        penaltyBoxWidth,
        penaltyBoxHeight,
      ),
      paint,
    );

    // Outer border
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
