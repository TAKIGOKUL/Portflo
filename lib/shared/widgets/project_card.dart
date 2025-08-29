import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/animations.dart';
import '../../core/responsive/responsive_utils.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.animationDelay = Duration.zero,
  });

  final Map<String, dynamic> project;
  final VoidCallback? onTap;
  final Duration animationDelay;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: AppAnimations.normal,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -_hoverController.value * 2),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkCard,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12 + (_hoverController.value * 6),
                      offset: Offset(0, 6 + (_hoverController.value * 3)),
                    ),
                    if (_isHovered)
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                  ],
                  border: Border.all(
                    color: _isHovered 
                        ? AppTheme.primaryColor.withOpacity(0.3)
                        : AppTheme.darkBorder.withOpacity(0.1),
                    width: _isHovered ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Image
                    _buildProjectImage(isMobile, isTablet),
                    
                    // Project Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 16 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Project Title
                            Text(
                              widget.project['title'] ?? 'Untitled Project',
                              style: AppTheme.headingSmall.copyWith(
                                fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
                                color: AppTheme.darkTextPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Project Category
                            if (widget.project['category'] != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppTheme.primaryColor.withOpacity(0.3),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  widget.project['category'],
                                  style: AppTheme.caption.copyWith(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            
                            const SizedBox(height: 12),
                            
                            // Project Description
                            Expanded(
                              child: Text(
                                widget.project['description'] ?? 'No description available.',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.darkTextSecondary,
                                  height: 1.4,
                                  fontSize: isMobile ? 12 : (isTablet ? 13 : 14),
                                ),
                                maxLines: isMobile ? 3 : 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Technologies
                            _buildTechnologies(isMobile, isTablet),
                            
                            const SizedBox(height: 16),
                            
                            // Action Buttons
                            _buildActionButtons(context, isMobile, isTablet),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).animate(delay: widget.animationDelay)
        .fadeIn(duration: AppAnimations.slow, curve: AppAnimations.entranceCurve)
        .slideY(
          begin: 20,
          end: 0,
          duration: AppAnimations.slow,
          curve: AppAnimations.entranceCurve,
        );
  }

  Widget _buildProjectImage(bool isMobile, bool isTablet) {
    final imageHeight = isMobile ? 140.0 : (isTablet ? 160.0 : 180.0);
    
    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        gradient: AppTheme.cardGradient,
      ),
      child: Stack(
        children: [
          // Project Image
          if (widget.project['imageUrl'] != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.project['imageUrl'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppTheme.darkCard,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppTheme.darkCard,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppTheme.darkTextSecondary,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),

          // Featured Badge
          if (widget.project['featured'] == true)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Featured',
                  style: AppTheme.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

          // Status Badge
          if (widget.project['status'] != null)
            Positioned(
              top: 12,
              right: 12,
              child: _buildStatusBadge(),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final status = widget.project['status'] as String;
    Color badgeColor;
    
    switch (status.toLowerCase()) {
      case 'completed':
        badgeColor = AppTheme.successColor;
        break;
      case 'in development':
      case 'in progress':
        badgeColor = AppTheme.warningColor;
        break;
      default:
        badgeColor = AppTheme.darkTextSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        status,
        style: AppTheme.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildTechnologies(bool isMobile, bool isTablet) {
    final technologies = widget.project['technologies'] as List<dynamic>? ?? [];
    
    if (technologies.isEmpty) return const SizedBox.shrink();

    final maxTechs = isMobile ? 2 : (isTablet ? 3 : 4);

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        ...technologies.take(maxTechs).map((tech) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppTheme.darkBorder.withOpacity(0.3),
              width: 0.5,
            ),
          ),
          child: Text(
            tech.toString(),
            style: AppTheme.caption.copyWith(
              color: AppTheme.darkTextSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        )),
        
        if (technologies.length > maxTechs)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Text(
              '+${technologies.length - maxTechs}',
              style: AppTheme.caption.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile, bool isTablet) {
    final githubUrl = widget.project['githubUrl'] as String?;
    final liveUrl = widget.project['liveUrl'] as String?;
    final buttonHeight = isMobile ? 32.0 : (isTablet ? 36.0 : 40.0);
    final fontSize = isMobile ? 11.0 : (isTablet ? 12.0 : 13.0);

    return Row(
      children: [
        if (liveUrl != null)
          Expanded(
            child: SizedBox(
              height: buttonHeight,
              child: ElevatedButton.icon(
                onPressed: () => _launchUrl(liveUrl),
                icon: Icon(Icons.open_in_new, size: isMobile ? 12 : 14),
                label: Text(
                  'Live',
                  style: TextStyle(fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        
        if (liveUrl != null && githubUrl != null)
          SizedBox(width: isMobile ? 6 : 8),
        
        if (githubUrl != null)
          Expanded(
            child: SizedBox(
              height: buttonHeight,
              child: OutlinedButton.icon(
                onPressed: () => _launchUrl(githubUrl),
                icon: Icon(Icons.code, size: isMobile ? 12 : 14),
                label: Text(
                  'Code',
                  style: TextStyle(fontSize: fontSize),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: BorderSide(color: AppTheme.primaryColor),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
