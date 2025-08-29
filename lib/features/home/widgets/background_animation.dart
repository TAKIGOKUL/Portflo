import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';

class BackgroundAnimation extends StatelessWidget {
  const BackgroundAnimation({
    super.key,
    required this.controller,
  });

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: ParticlesPainter(
                animationValue: controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  ParticlesPainter({required this.animationValue});

  final double animationValue;
  static final List<Particle> particles = _generateParticles();

  static List<Particle> _generateParticles() {
    final random = math.Random();
    // Reduced from 50 to 15 particles for better performance
    return List.generate(15, (index) {
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3 + 1, // Reduced max size
        speed: random.nextDouble() * 0.01 + 0.003, // Reduced speed
        opacity: random.nextDouble() * 0.3 + 0.1, // Reduced opacity
        color: index % 3 == 0
            ? AppTheme.primaryColor
            : index % 3 == 1
                ? AppTheme.secondaryColor
                : AppTheme.accentColor,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Skip animation on very small screens for performance
    if (size.width < 300 || size.height < 300) {
      return;
    }

    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color.withValues(
          alpha: particle.opacity * (0.5 + 0.5 * math.sin(animationValue * 2 * math.pi)),
        )
        ..style = PaintingStyle.fill;

      final x = (particle.x + animationValue * particle.speed) % 1.0 * size.width;
      final y = particle.y * size.height;

      // Simplified glow effect
      final glowPaint = Paint()
        ..color = particle.color.withValues(alpha: particle.opacity * 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawCircle(Offset(x, y), particle.size * 1.5, glowPaint);
      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }

    // Only draw connections on larger screens for performance
    if (size.width > 600) {
      _drawConnections(canvas, size);
    }
  }

  void _drawConnections(Canvas canvas, Size size) {
    final connectionPaint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: 0.05)
      ..strokeWidth = 0.5;

    // Limit connection checks for performance
    final maxConnections = math.min(particles.length, 8);
    
    for (int i = 0; i < maxConnections; i++) {
      for (int j = i + 1; j < math.min(i + 3, particles.length); j++) {
        final particle1 = particles[i];
        final particle2 = particles[j];

        final x1 = (particle1.x + animationValue * particle1.speed) % 1.0 * size.width;
        final y1 = particle1.y * size.height;
        final x2 = (particle2.x + animationValue * particle2.speed) % 1.0 * size.width;
        final y2 = particle2.y * size.height;

        final distance = math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2));
        
        if (distance < 100) { // Reduced connection distance
          final opacity = (1 - distance / 100) * 0.2; // Reduced opacity
          connectionPaint.color = AppTheme.primaryColor.withValues(alpha: opacity);
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), connectionPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Only repaint if animation value changed significantly
    return (oldDelegate as ParticlesPainter).animationValue != animationValue;
  }
}

class Particle {
  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.color,
  });

  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final Color color;
}
