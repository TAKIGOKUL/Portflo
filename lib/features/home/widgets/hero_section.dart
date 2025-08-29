import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/utils/animations.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_button.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.onScrollToNext,
  });

  final VoidCallback onScrollToNext;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4), // Slower animation for better performance
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3), // Slower animation for better performance
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = ResponsiveUtils.getHeroHeight(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      height: heroHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppTheme.backgroundGradient,
      ),
      child: Stack(
        children: [
          // Background Elements - Only on larger screens for performance
          if (!isMobile) _buildBackgroundElements(),
          
          // Main Content
          SafeArea(
            child: Padding(
              padding: ResponsiveUtils.getResponsivePadding(context),
              child: isMobile
                  ? _buildMobileLayout(context)
                  : isTablet
                      ? _buildTabletLayout(context)
                      : _buildDesktopLayout(context),
            ),
          ),
          
          // Scroll Indicator
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: _buildScrollIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        // Floating circles - Simplified for performance
        AnimatedBuilder(
          animation: _floatingController,
          builder: (context, child) {
            return Positioned(
              top: 100 + (_floatingController.value * 15), // Reduced movement
              right: 50,
              child: Container(
                width: 150, // Reduced size
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.primaryColor.withValues(alpha: 0.08), // Reduced opacity
                      AppTheme.secondaryColor.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        
        AnimatedBuilder(
          animation: _floatingController,
          builder: (context, child) {
            return Positioned(
              top: 300 - (_floatingController.value * 10), // Reduced movement
              left: 30,
              child: Container(
                width: 100, // Reduced size
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.accentColor.withValues(alpha: 0.06), // Reduced opacity
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        
        // Grid pattern - Only on desktop for performance
        if (ResponsiveUtils.isDesktop(context))
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(),
            ),
          ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        _buildHeroContent(context, isMobile: true),
        const Spacer(),
        _buildActionButtons(context, isColumn: true),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        _buildHeroContent(context, isMobile: false),
        const SizedBox(height: 40),
        _buildActionButtons(context, isColumn: false),
        const Spacer(),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroContent(context, isMobile: false),
              const SizedBox(height: 40),
              _buildActionButtons(context, isColumn: false),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildHeroImage(),
        ),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context, {required bool isMobile}) {
    final fontMultiplier = ResponsiveUtils.getFontSizeMultiplier(context);
    
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Greeting
        Text(
          'Hello, I\'m',
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.darkTextSecondary,
            fontSize: (18 * fontMultiplier).clamp(16, 24),
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate(delay: 200.ms).fadeIn().slideY(begin: 30, end: 0),
        
        const SizedBox(height: 8),
        
        // Name with gradient
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            AppConstants.name,
            style: AppTheme.headingLarge.copyWith(
              color: Colors.white,
              fontSize: (48 * fontMultiplier).clamp(32, 72),
              height: 1.1,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ).animate(delay: 400.ms).fadeIn().slideY(begin: 50, end: 0),
        
        const SizedBox(height: 12),
        
        // Title
        Text(
          AppConstants.title,
          style: AppTheme.headingMedium.copyWith(
            color: AppTheme.darkTextPrimary,
            fontSize: (36 * fontMultiplier).clamp(24, 48),
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate(delay: 600.ms).fadeIn().slideY(begin: 40, end: 0),
        
        const SizedBox(height: 16),
        
        // Subtitle with typewriter effect
        Text(
          AppConstants.subtitle,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.darkTextSecondary,
            fontSize: (18 * fontMultiplier).clamp(16, 22),
            height: 1.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate(delay: 800.ms).fadeIn(
          duration: const Duration(milliseconds: 2000),
        ),
        
        const SizedBox(height: 24),
        
        // Skills tags
        _buildSkillsTags(isMobile),
      ],
    );
  }

  Widget _buildSkillsTags(bool isMobile) {
    final mainSkills = ['Flutter', 'React', 'Node.js', 'UI/UX'];
    
    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: 12,
      runSpacing: 8,
      children: mainSkills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.darkCard.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            skill,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    ).animate(delay: 1000.ms).fadeIn().slideY(begin: 20, end: 0);
  }

  Widget _buildActionButtons(BuildContext context, {required bool isColumn}) {
    final buttons = [
      CustomButtonFactories.gradient(
        text: 'View My Work',
        onPressed: widget.onScrollToNext,
        icon: Icons.arrow_downward,
        size: ButtonSize.large,
        isFullWidth: isColumn,
      ),
      CustomButtonFactories.outlined(
        text: 'Download CV',
        onPressed: () {
          // Implement CV download
        },
        icon: Icons.download,
        size: ButtonSize.large,
        isFullWidth: isColumn,
      ),
    ];

    return isColumn
        ? Column(
            children: [
              buttons[0].animate(delay: 1200.ms).fadeIn().scale(),
              const SizedBox(height: 16),
              buttons[1].animate(delay: 1400.ms).fadeIn().scale(),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              buttons[0].animate(delay: 1200.ms).fadeIn().scale(),
              const SizedBox(width: 20),
              buttons[1].animate(delay: 1400.ms).fadeIn().scale(),
            ],
          );
  }

  Widget _buildHeroImage() {
    return Center(
      child: AnimatedBuilder(
        animation: _floatingController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatingController.value * 20),
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: ClipOval(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.darkCard,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 200,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ).animate(delay: 1000.ms).fadeIn().scale();
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return GestureDetector(
              onTap: widget.onScrollToNext,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(
                      0.3 + (_pulseController.value * 0.4),
                    ),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppTheme.primaryColor.withOpacity(
                    0.7 + (_pulseController.value * 0.3),
                  ),
                  size: 24,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Scroll to explore',
          style: AppTheme.caption.copyWith(
            color: AppTheme.darkTextTertiary,
          ),
        ),
      ],
    ).animate(delay: 1600.ms).fadeIn();
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Skip grid on small screens for performance
    if (size.width < 800 || size.height < 600) {
      return;
    }

    final paint = Paint()
      ..color = AppTheme.darkBorder.withValues(alpha: 0.05) // Reduced opacity
      ..strokeWidth = 0.5; // Thinner lines

    const spacing = 80.0; // Increased spacing for better performance

    // Limit the number of lines drawn for performance
    final maxLines = 20;
    final xLines = math.min((size.width / spacing).ceil(), maxLines);
    final yLines = math.min((size.height / spacing).ceil(), maxLines);

    for (int i = 0; i < xLines; i++) {
      final x = i * spacing;
      if (x < size.width) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
    }

    for (int i = 0; i < yLines; i++) {
      final y = i * spacing;
      if (y < size.height) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
