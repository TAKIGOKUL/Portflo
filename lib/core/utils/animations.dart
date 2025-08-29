import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimations {
  // Animation Durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Animation Curves
  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve entranceCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;
  static const Curve bounceCurve = Curves.elasticOut;

  // Page Transition Animations
  static Widget slideTransition({
    required Widget child,
    required Animation<double> animation,
    Offset beginOffset = const Offset(1.0, 0.0),
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: defaultCurve,
      )),
      child: child,
    );
  }

  static Widget fadeTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget scaleTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: defaultCurve,
      )),
      child: child,
    );
  }

  // Hero Section Animations
  static List<Effect> heroTextAnimation({
    Duration delay = Duration.zero,
  }) => [
    FadeEffect(
      duration: slow,
      delay: delay,
      curve: entranceCurve,
    ),
    SlideEffect(
      duration: slow,
      delay: delay,
      begin: const Offset(0, 50),
      end: Offset.zero,
      curve: entranceCurve,
    ),
  ];

  static List<Effect> heroImageAnimation({
    Duration delay = const Duration(milliseconds: 200),
  }) => [
    FadeEffect(
      duration: verySlow,
      delay: delay,
      curve: entranceCurve,
    ),
    ScaleEffect(
      duration: verySlow,
      delay: delay,
      begin: const Offset(0.8, 0.8),
      end: const Offset(1.0, 1.0),
      curve: entranceCurve,
    ),
    BlurEffect(
      duration: slow,
      delay: delay,
      begin: const Offset(10, 10),
      end: Offset.zero,
    ),
  ];

  // Card Animations
  static List<Effect> cardEntranceAnimation({
    Duration delay = Duration.zero,
  }) => [
    FadeEffect(
      duration: normal,
      delay: delay,
      curve: entranceCurve,
    ),
    SlideEffect(
      duration: normal,
      delay: delay,
      begin: const Offset(0, 30),
      end: Offset.zero,
      curve: entranceCurve,
    ),
    ScaleEffect(
      duration: normal,
      delay: delay,
      begin: const Offset(0.95, 0.95),
      end: const Offset(1.0, 1.0),
      curve: entranceCurve,
    ),
  ];

  static List<Effect> cardHoverAnimation() => [
    ScaleEffect(
      duration: fast,
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.02, 1.02),
      curve: defaultCurve,
    ),
    TintEffect(
      duration: fast,
      color: Colors.white.withOpacity(0.1),
    ),
  ];

  // Staggered List Animations
  static List<Effect> staggeredListAnimation({
    required int index,
    Duration baseDelay = const Duration(milliseconds: 100),
  }) => [
    FadeEffect(
      duration: normal,
      delay: baseDelay * index,
      curve: entranceCurve,
    ),
    SlideEffect(
      duration: normal,
      delay: baseDelay * index,
      begin: const Offset(-30, 0),
      end: Offset.zero,
      curve: entranceCurve,
    ),
  ];

  // Button Animations
  static List<Effect> buttonPressAnimation() => [
    ScaleEffect(
      duration: const Duration(milliseconds: 100),
      begin: const Offset(1.0, 1.0),
      end: const Offset(0.95, 0.95),
      curve: Curves.easeInOut,
    ),
  ];

  static List<Effect> buttonHoverAnimation() => [
    ScaleEffect(
      duration: fast,
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.05, 1.05),
      curve: defaultCurve,
    ),
    ShimmerEffect(
      duration: const Duration(milliseconds: 1500),
      color: Colors.white.withOpacity(0.3),
    ),
  ];

  // Loading Animations
  static List<Effect> pulseAnimation() => [
    ScaleEffect(
      duration: const Duration(milliseconds: 1000),
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.1, 1.1),
      curve: Curves.easeInOut,
    ),
  ];

  static List<Effect> shimmerAnimation() => [
    ShimmerEffect(
      duration: const Duration(milliseconds: 1500),
      color: Colors.white.withOpacity(0.3),
      angle: 0.5,
    ),
  ];

  // Navigation Animations
  static List<Effect> navItemAnimation({
    required int index,
  }) => [
    FadeEffect(
      duration: normal,
      delay: Duration(milliseconds: 50 * index),
      curve: entranceCurve,
    ),
    SlideEffect(
      duration: normal,
      delay: Duration(milliseconds: 50 * index),
      begin: const Offset(0, -20),
      end: Offset.zero,
      curve: entranceCurve,
    ),
  ];

  // Section Reveal Animations
  static List<Effect> sectionRevealAnimation({
    Duration delay = Duration.zero,
  }) => [
    FadeEffect(
      duration: slow,
      delay: delay,
      curve: entranceCurve,
    ),
    SlideEffect(
      duration: slow,
      delay: delay,
      begin: const Offset(0, 80),
      end: Offset.zero,
      curve: entranceCurve,
    ),
  ];

  // Floating Animations
  static List<Effect> floatingAnimation({
    Duration duration = const Duration(seconds: 3),
  }) => [
    MoveEffect(
      duration: duration,
      begin: Offset.zero,
      end: const Offset(0, -10),
      curve: Curves.easeInOut,
    ),
  ];

  // Gradient Text Animation
  static List<Effect> gradientTextAnimation() => [
    ShimmerEffect(
      duration: const Duration(seconds: 2),
      color: Colors.white.withOpacity(0.5),
      angle: 0.3,
    ),
  ];

  // Parallax Animation
  static Widget parallaxAnimation({
    required Widget child,
    required ScrollController scrollController,
    double speed = 0.5,
  }) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, _) {
        final scrollOffset = scrollController.hasClients 
            ? scrollController.offset * speed 
            : 0.0;
        
        return Transform.translate(
          offset: Offset(0, scrollOffset),
          child: child,
        );
      },
    );
  }

  // Typewriter Animation
  static List<Effect> typewriterAnimation({
    Duration duration = const Duration(milliseconds: 2000),
  }) => [
    FadeEffect(
      duration: duration,
      curve: Curves.easeInOut,
    ),
  ];

  // Reveal Animation with custom direction
  static List<Effect> revealAnimation({
    Duration delay = Duration.zero,
    SlideDirection direction = SlideDirection.up,
  }) {
    Offset beginOffset;
    switch (direction) {
      case SlideDirection.up:
        beginOffset = const Offset(0, 50);
        break;
      case SlideDirection.down:
        beginOffset = const Offset(0, -50);
        break;
      case SlideDirection.left:
        beginOffset = const Offset(50, 0);
        break;
      case SlideDirection.right:
        beginOffset = const Offset(-50, 0);
        break;
    }

    return [
      FadeEffect(
        duration: normal,
        delay: delay,
        curve: entranceCurve,
      ),
      SlideEffect(
        duration: normal,
        delay: delay,
        begin: beginOffset,
        end: Offset.zero,
        curve: entranceCurve,
      ),
    ];
  }
}

enum SlideDirection { up, down, left, right }

// Custom Animation Extensions
extension AnimationExtensions on Widget {
  Widget animateOnScroll({
    required ScrollController scrollController,
    double threshold = 0.1,
    List<Effect>? effects,
  }) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final screenHeight = MediaQuery.of(context).size.height;
        final scrollOffset = scrollController.hasClients 
            ? scrollController.offset 
            : 0.0;
        
        final shouldAnimate = scrollOffset > screenHeight * threshold;
        
        return shouldAnimate 
            ? animate(effects: effects ?? AppAnimations.sectionRevealAnimation())
            : this;
      },
    );
  }

  Widget staggeredAnimation({
    required int index,
    Duration delay = const Duration(milliseconds: 100),
    List<Effect>? effects,
  }) {
    return animate(
      effects: effects ?? AppAnimations.staggeredListAnimation(
        index: index,
        baseDelay: delay,
      ),
    );
  }

  Widget hoverAnimation({
    List<Effect>? effects,
  }) {
    return MouseRegion(
      onEnter: (_) {},
      onExit: (_) {},
      child: animate(
        effects: effects ?? AppAnimations.cardHoverAnimation(),
      ),
    );
  }
}
