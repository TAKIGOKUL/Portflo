import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/animations.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({
    super.key,
    required this.onSectionTap,
  });

  final Function(String) onSectionTap;

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, themeProvider),
            
            const SizedBox(height: 24),
            
            // Navigation Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: navigationProvider.sections.length,
                itemBuilder: (context, index) {
                  final section = navigationProvider.sections[index];
                  return _MobileNavItem(
                    section: section,
                    isActive: navigationProvider.currentSection == section,
                    onTap: () => onSectionTap(section),
                    animationDelay: Duration(milliseconds: 100 * index),
                  );
                },
              ),
            ),
            
            // Theme Toggle Section
            _buildThemeToggle(context, themeProvider),
            
            // Footer
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.backgroundGradient,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppTheme.cardShadows,
                ),
                child: const Icon(
                  Icons.code,
                  color: Colors.white,
                  size: 28,
                ),
              ).animate().scale(delay: 200.ms),
              
              const SizedBox(width: 16),
              
              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portfolio',
                      style: AppTheme.headingSmall.copyWith(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Developer Portfolio',
                      style: AppTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme',
            style: AppTheme.bodyMedium.copyWith(
              color: Theme.of(context).textTheme.titleMedium?.color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildThemeChip(context, themeProvider, CustomTheme.noctis, 'Noctis', Icons.nightlight_round),
              _buildThemeChip(context, themeProvider, CustomTheme.sublimeGit, 'SublimeGit', Icons.code),
              _buildThemeChip(context, themeProvider, CustomTheme.dark, 'Dark', Icons.dark_mode),
              _buildThemeChip(context, themeProvider, CustomTheme.light, 'Light', Icons.light_mode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeChip(BuildContext context, ThemeProvider themeProvider, CustomTheme theme, String label, IconData icon) {
    final isSelected = themeProvider.currentTheme == theme;
    
    return GestureDetector(
      onTap: () => themeProvider.setTheme(theme),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).primaryColor 
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? Theme.of(context).primaryColor 
                : Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.caption.copyWith(
                color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            '© 2024 Portfolio',
            style: AppTheme.caption.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Built with Flutter',
            style: AppTheme.caption.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileNavItem extends StatefulWidget {
  const _MobileNavItem({
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
  State<_MobileNavItem> createState() => _MobileNavItemState();
}

class _MobileNavItemState extends State<_MobileNavItem>
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
    final icon = navigationProvider.getSectionIcon(widget.section);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.isActive
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                    : (_isHovered
                        ? Theme.of(context).cardColor.withValues(alpha: 0.5)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(12),
                border: widget.isActive 
                    ? Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.3))
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: widget.isActive
                        ? Theme.of(context).primaryColor
                        : (_isHovered
                            ? Theme.of(context).textTheme.titleMedium?.color
                            : Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      displayName,
                      style: AppTheme.bodyMedium.copyWith(
                        color: widget.isActive
                            ? Theme.of(context).primaryColor
                            : (_isHovered
                                ? Theme.of(context).textTheme.titleMedium?.color
                                : Theme.of(context).textTheme.bodyMedium?.color),
                        fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                  if (widget.isActive)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    ).animate(delay: widget.animationDelay)
        .slideX(begin: -20, end: 0, duration: AppAnimations.normal)
        .fadeIn(duration: AppAnimations.normal);
  }
}
