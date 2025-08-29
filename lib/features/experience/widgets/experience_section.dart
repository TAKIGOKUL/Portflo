import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/constants/app_constants.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
              _buildExperienceTimeline(context),
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
          'Work Experience',
          style: AppTheme.headingLarge.copyWith(
            color: AppTheme.darkTextPrimary,
          ),
        ).animate().fadeIn().slideY(begin: 30, end: 0),
        
        const SizedBox(height: 16),
        
        Text(
          'My professional journey',
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

  Widget _buildExperienceTimeline(BuildContext context) {
    final experiences = AppConstants.experiences;
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        return _buildExperienceItem(
          experiences[index],
          index,
          index == experiences.length - 1,
        );
      },
    );
  }

  Widget _buildExperienceItem(
    Map<String, dynamic> experience,
    int index,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 200,
                color: AppTheme.darkBorder,
              ),
          ],
        ),
        
        const SizedBox(width: 24),
        
        // Content
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              color: AppTheme.darkCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.darkBorder,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        experience['position'] ?? '',
                        style: AppTheme.headingSmall.copyWith(
                          color: AppTheme.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: experience['endDate'] == null
                            ? AppTheme.successColor.withOpacity(0.1)
                            : AppTheme.darkBorder.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        experience['endDate'] == null ? 'Current' : 'Past',
                        style: AppTheme.caption.copyWith(
                          color: experience['endDate'] == null
                              ? AppTheme.successColor
                              : AppTheme.darkTextSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  experience['company'] ?? '',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.darkTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppTheme.darkTextSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      experience['location'] ?? '',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.darkTextSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: AppTheme.darkTextSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDateRange(
                        experience['startDate'],
                        experience['endDate'],
                      ),
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.darkTextSecondary,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  experience['description'] ?? '',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.darkTextSecondary,
                    height: 1.5,
                  ),
                ),
                
                if (experience['technologies'] != null) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (experience['technologies'] as List<dynamic>)
                        .map((tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tech.toString(),
                                style: AppTheme.caption.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ).animate(delay: Duration(milliseconds: 400 + index * 200))
        .fadeIn()
        .slideX(begin: -50, end: 0);
  }

  String _formatDateRange(String? startDate, String? endDate) {
    if (startDate == null) return '';
    
    final start = DateTime.tryParse(startDate);
    if (start == null) return '';
    
    final startFormatted = '${_getMonthName(start.month)} ${start.year}';
    
    if (endDate == null) {
      return '$startFormatted - Present';
    }
    
    final end = DateTime.tryParse(endDate);
    if (end == null) return startFormatted;
    
    final endFormatted = '${_getMonthName(end.month)} ${end.year}';
    return '$startFormatted - $endFormatted';
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
}
