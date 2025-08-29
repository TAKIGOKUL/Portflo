import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_button.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      width: double.infinity,
      padding: ResponsiveUtils.getSectionPadding(context),
      color: AppTheme.darkSurface,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveUtils.getContentWidth(context),
          ),
          child: isMobile
              ? _buildMobileLayout(context)
              : isTablet
                  ? _buildTabletLayout(context)
                  : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader(context, isCenter: true),
        const SizedBox(height: 40),
        _buildProfileImage(context),
        const SizedBox(height: 32),
        _buildAboutContent(context, isCenter: true),
        const SizedBox(height: 32),
        _buildStats(context, isColumn: true),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader(context, isCenter: true),
        const SizedBox(height: 50),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildProfileImage(context),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutContent(context, isCenter: false),
                  const SizedBox(height: 32),
                  _buildStats(context, isColumn: false),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader(context, isCenter: true),
        const SizedBox(height: 60),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildProfileImage(context),
            ),
            const SizedBox(width: 60),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutContent(context, isCenter: false),
                  const SizedBox(height: 40),
                  _buildStats(context, isColumn: false),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required bool isCenter}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'About Me',
          style: AppTheme.headingLarge.copyWith(
            color: AppTheme.darkTextPrimary,
            fontSize: ResponsiveUtils.isMobile(context) ? 36 : 48,
          ),
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
        ).animate().fadeIn().slideY(begin: 30, end: 0),
        
        const SizedBox(height: 8),
        
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate(delay: 200.ms).scaleX(),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final imageSize = ResponsiveUtils.isMobile(context) ? 280.0 : 350.0;
    
    return Center(
      child: Container(
        width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.primaryGradient,
          boxShadow: AppTheme.cardShadows,
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.darkCard,
            image: const DecorationImage(
              image: AssetImage('assets/images/profile.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
          ),
        ),
      ),
    ).animate(delay: 300.ms).fadeIn().scale();
  }

  Widget _buildAboutContent(BuildContext context, {required bool isCenter}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Hello! I\'m a passionate developer',
          style: AppTheme.headingMedium.copyWith(
            color: AppTheme.primaryColor,
            fontSize: ResponsiveUtils.isMobile(context) ? 24 : 28,
          ),
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
        ).animate(delay: 400.ms).fadeIn().slideY(begin: 20, end: 0),
        
        const SizedBox(height: 20),
        
        Text(
          AppConstants.bio,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.darkTextSecondary,
            height: 1.6,
          ),
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
        ).animate(delay: 500.ms).fadeIn().slideY(begin: 20, end: 0),
        
        const SizedBox(height: 24),
        
        Wrap(
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            CustomButtonFactories.primary(
              text: 'Download CV',
              onPressed: () {
                // Implement CV download
              },
              icon: Icons.download,
            ),
            CustomButtonFactories.outlined(
              text: 'Contact Me',
              onPressed: () {
                // Implement contact navigation
              },
              icon: Icons.mail,
            ),
          ],
        ).animate(delay: 600.ms).fadeIn().slideY(begin: 20, end: 0),
      ],
    );
  }

  Widget _buildStats(BuildContext context, {required bool isColumn}) {
    final stats = [
      {'number': '3+', 'label': 'Years Experience'},
      {'number': '50+', 'label': 'Projects Completed'},
      {'number': '20+', 'label': 'Happy Clients'},
      {'number': '100%', 'label': 'Success Rate'},
    ];

    return isColumn
        ? Column(
            children: stats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildStatItem(stat, index),
              );
            }).toList(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: stats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;
              return Expanded(
                child: _buildStatItem(stat, index),
              );
            }).toList(),
          );
  }

  Widget _buildStatItem(Map<String, String> stat, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: AppTheme.cardRadius,
        border: Border.all(
          color: AppTheme.darkBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            stat['number']!,
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stat['label']!,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.darkTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate(delay: Duration(milliseconds: 700 + (index * 100)))
        .fadeIn()
        .slideY(begin: 30, end: 0);
  }
}
