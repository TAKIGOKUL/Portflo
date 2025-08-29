import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/utils/animations.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';

class AppNavigation extends StatelessWidget implements PreferredSizeWidget {
  const AppNavigation({
    super.key,
    required this.onSectionTap,
    this.onMenuTap,
  });

  final Function(String) onSectionTap;
  final VoidCallback? onMenuTap;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final navHeight = ResponsiveUtils.getNavigationHeight(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      height: navHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: ResponsiveUtils.getResponsivePadding(context).copyWith(
            top: 0,
            bottom: 0,
          ),
          child: Row(
            children: [
              // Logo/Brand
              _buildLogo().animate().slideX(begin: -100, end: 0),
              
              const Spacer(),
              
              // Navigation Items (Desktop only)
              if (!isMobile) _buildNavigationItems(context, navigationProvider),
              
              const SizedBox(width: 24),
              
              // Theme Toggle Button
              _buildThemeToggle(themeProvider).animate(delay: 400.ms).fadeIn(),
              
              const SizedBox(width: 16),
              
              // Mobile Menu Button or Theme Toggle
              if (isMobile && onMenuTap != null)
                _buildMobileMenuButton()
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.cardShadows,
              ),
              child: const Icon(
                Icons.code,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Portfolio',
              style: AppTheme.headingSmall.copyWith(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItems(BuildContext context, NavigationProvider navigationProvider) {
    return Row(
      children: navigationProvider.sections.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;
        final isActive = navigationProvider.currentSection == section;
        
        return _NavigationItem(
          section: section,
          isActive: isActive,
          onTap: () => onSectionTap(section),
          animationDelay: Duration(milliseconds: 100 * index),
        );
      }).toList(),
    );
  }

  Widget _buildThemeToggle(ThemeProvider themeProvider) {
    return Builder(
      builder: (context) => Tooltip(
        message: 'Current: ${themeProvider.getThemeName()}\nTap to cycle themes',
        child: IconButton(
          onPressed: themeProvider.cycleTheme,
          icon: AnimatedSwitcher(
            duration: AppAnimations.normal,
            child: Icon(
              themeProvider.getThemeIcon(),
              key: ValueKey(themeProvider.currentTheme),
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
          tooltip: 'Cycle Themes',
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return IconButton(
      onPressed: onMenuTap,
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
        size: 24,
      ),
      tooltip: 'Open Menu',
    ).animate().fadeIn();
  }
}

class _NavigationItem extends StatefulWidget {
  const _NavigationItem({
    required this.section,
    required this.isActive,
    required this.onTap,
    required this.animationDelay,
  });

  final String section;
  final bool isActive;
  final VoidCallback onTap;
  final Duration animationDelay;

  @override
  State<_NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<_NavigationItem>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: AppAnimations.fast,
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

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
    final displayName = navigationProvider.getSectionDisplayName(widget.section);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.isActive
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                    : (_isHovered
                        ? Theme.of(context).cardColor.withValues(alpha: 0.5)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(8),
                border: widget.isActive
                    ? Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.3))
                    : null,
              ),
              child: Text(
                displayName,
                style: AppTheme.bodyMedium.copyWith(
                  color: widget.isActive
                      ? Theme.of(context).primaryColor
                      : (_isHovered
                          ? Theme.of(context).textTheme.titleMedium?.color
                          : Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
    ).animate(delay: widget.animationDelay)
        .slideY(begin: -20, end: 0, duration: AppAnimations.normal)
        .fadeIn(duration: AppAnimations.normal);
  }
}


