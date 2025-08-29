import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/constants/app_constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveUtils.getSectionPadding(context),
      color: AppTheme.darkBackground,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveUtils.getContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(),
              const SizedBox(height: 60),
              _buildSkillsGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'Skills & Expertise',
          style: AppTheme.headingLarge.copyWith(
            color: AppTheme.darkTextPrimary,
          ),
        ).animate().fadeIn().slideY(begin: 30, end: 0),
        
        const SizedBox(height: 16),
        
        Text(
          'Technologies and tools I work with',
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.darkTextSecondary,
          ),
        ).animate(delay: 200.ms).fadeIn().slideY(begin: 20, end: 0),
        
        const SizedBox(height: 16),
        
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate(delay: 300.ms).scaleX(),
      ],
    );
  }

  Widget _buildSkillsGrid(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Column(
      children: [
        // Technical Skills
        _buildSkillCategory(
          'Technical Skills',
          AppConstants.technicalSkills,
          isMobile ? 2 : 3,
          0,
        ),
        
        const SizedBox(height: 40),
        
        // Soft Skills
        _buildSkillCategory(
          'Soft Skills',
          AppConstants.softSkills,
          isMobile ? 2 : 4,
          AppConstants.technicalSkills.length,
        ),
      ],
    );
  }

  Widget _buildSkillCategory(
    String title,
    List<String> skills,
    int crossAxisCount,
    int baseDelay,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.headingSmall.copyWith(
            color: AppTheme.primaryColor,
          ),
        ).animate(delay: Duration(milliseconds: 400 + baseDelay * 50))
            .fadeIn()
            .slideX(begin: -30, end: 0),
        
        const SizedBox(height: 24),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 3.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return _buildSkillCard(
              skills[index],
              baseDelay + index,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSkillCard(String skill, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.darkBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          skill,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.darkTextPrimary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ).animate(delay: Duration(milliseconds: 500 + index * 100))
        .fadeIn()
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }
}
