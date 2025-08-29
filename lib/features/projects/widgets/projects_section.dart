import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: ResponsiveUtils.getSectionPadding(context),
      color: AppTheme.darkSurface,
      child: Column(
        children: [
          _buildSectionHeader(context),
          SizedBox(height: isMobile ? 32 : 48),
          _buildProjectsContent(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Column(
      children: [
        Text(
          'Featured Projects',
          style: AppTheme.headingLarge.copyWith(
            color: AppTheme.darkTextPrimary,
            fontSize: isMobile ? 28 : 36,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideY(begin: 30, end: 0),
        
        const SizedBox(height: 16),
        
        Text(
          'Some of my recent work and achievements',
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.darkTextSecondary,
            fontSize: isMobile ? 14 : 16,
          ),
          textAlign: TextAlign.center,
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

  Widget _buildProjectsContent(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final projects = AppConstants.projects;

    if (isMobile) {
      // Mobile: Horizontal scrolling cards
      return SizedBox(
        height: 420, // Fixed height for mobile
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return Container(
              width: 300, // Fixed width for mobile cards
              margin: const EdgeInsets.only(right: 16),
              child: ProjectCard(
                project: projects[index],
                animationDelay: Duration(milliseconds: 400 + index * 100),
                onTap: () => _showProjectDetails(context, projects[index]),
              ),
            );
          },
        ),
      );
    }

    if (isTablet) {
      // Tablet: 2-column grid
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(
            project: projects[index],
            animationDelay: Duration(milliseconds: 400 + index * 200),
            onTap: () => _showProjectDetails(context, projects[index]),
          );
        },
      );
    }

    // Desktop: 3-column grid
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return ProjectCard(
          project: projects[index],
          animationDelay: Duration(milliseconds: 400 + index * 200),
          onTap: () => _showProjectDetails(context, projects[index]),
        );
      },
    );
  }

  void _showProjectDetails(BuildContext context, Map<String, dynamic> project) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 600,
            maxHeight: isMobile ? double.infinity : 500,
          ),
          margin: isMobile ? const EdgeInsets.all(16) : null,
          padding: EdgeInsets.all(isMobile ? 20 : 24),
          decoration: BoxDecoration(
            color: AppTheme.darkCard,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppTheme.cardShadows,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project['title'] ?? 'Project',
                      style: AppTheme.headingMedium.copyWith(
                        color: AppTheme.darkTextPrimary,
                        fontSize: isMobile ? 20 : 24,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: AppTheme.darkTextSecondary,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (project['category'] != null || project['status'] != null)
                        Row(
                          children: [
                            if (project['category'] != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppTheme.primaryColor.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  project['category'],
                                  style: AppTheme.caption.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            if (project['status'] != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(project['status']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _getStatusColor(project['status']).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  project['status'],
                                  style: AppTheme.caption.copyWith(
                                    color: _getStatusColor(project['status']),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      
                      if (project['category'] != null || project['status'] != null)
                        const SizedBox(height: 16),
                      
                      Text(
                        project['longDescription'] ?? project['description'] ?? '',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.darkTextSecondary,
                          height: 1.6,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      if (project['technologies'] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Technologies Used:',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.darkTextPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (project['technologies'] as List<dynamic>).map((tech) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppTheme.primaryColor.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  tech.toString(),
                                  style: AppTheme.caption.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          if (project['liveUrl'] != null)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _launchUrl(project['liveUrl']),
                                icon: const Icon(Icons.open_in_new, size: 18),
                                label: const Text('View Live'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          
                          if (project['liveUrl'] != null && project['githubUrl'] != null)
                            const SizedBox(width: 12),
                          
                          if (project['githubUrl'] != null)
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _launchUrl(project['githubUrl']),
                                icon: const Icon(Icons.code, size: 18),
                                label: const Text('View Code'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.primaryColor,
                                  side: BorderSide(color: AppTheme.primaryColor),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppTheme.successColor;
      case 'in development':
      case 'in progress':
        return AppTheme.warningColor;
      default:
        return AppTheme.darkTextSecondary;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
