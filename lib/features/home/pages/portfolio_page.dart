import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/animations.dart';
import '../../navigation/providers/navigation_provider.dart';
import '../../navigation/widgets/app_navigation.dart';
import '../../navigation/widgets/mobile_drawer.dart';
import '../widgets/hero_section.dart';
import '../../about/widgets/about_section.dart';
import '../../skills/widgets/skills_section.dart';
import '../../projects/widgets/projects_section.dart';
import '../../experience/widgets/experience_section.dart';
import '../../contact/widgets/contact_section.dart';
import '../widgets/background_animation.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _backgroundController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Listen to scroll changes to update navigation
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Auto-update navigation based on scroll position
    final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
    final scrollOffset = _scrollController.offset;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define approximate section positions (you may need to adjust these)
    if (scrollOffset < screenHeight * 0.8) {
      navigationProvider.setCurrentSection('home');
    } else if (scrollOffset < screenHeight * 1.8) {
      navigationProvider.setCurrentSection('about');
    } else if (scrollOffset < screenHeight * 2.8) {
      navigationProvider.setCurrentSection('skills');
    } else if (scrollOffset < screenHeight * 3.8) {
      navigationProvider.setCurrentSection('projects');
    } else if (scrollOffset < screenHeight * 4.8) {
      navigationProvider.setCurrentSection('experience');
    } else {
      navigationProvider.setCurrentSection('contact');
    }
  }

  void _scrollToSection(String section) {
    final screenHeight = MediaQuery.of(context).size.height;
    double targetOffset;

    switch (section) {
      case 'home':
        targetOffset = 0;
        break;
      case 'about':
        targetOffset = screenHeight * 0.9;
        break;
      case 'skills':
        targetOffset = screenHeight * 1.9;
        break;
      case 'projects':
        targetOffset = screenHeight * 2.9;
        break;
      case 'experience':
        targetOffset = screenHeight * 3.9;
        break;
      case 'contact':
        targetOffset = screenHeight * 4.9;
        break;
      default:
        targetOffset = 0;
    }

    _scrollController.animateTo(
      targetOffset,
      duration: AppAnimations.slow,
      curve: AppAnimations.defaultCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, _) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppTheme.darkBackground,
          appBar: AppNavigation(
            onSectionTap: _scrollToSection,
            onMenuTap: isMobile ? () => _scaffoldKey.currentState?.openDrawer() : null,
          ),
          drawer: isMobile ? MobileDrawer(
            onSectionTap: (section) {
              _scrollToSection(section);
              Navigator.of(context).pop();
            },
          ) : null,
          body: Stack(
            children: [
              // Animated Background
              BackgroundAnimation(
                controller: _backgroundController,
              ),
              
              // Main Content
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Content Sections
                  SliverList(
                    delegate: SliverChildListDelegate([
                      // Hero Section
                      HeroSection(
                        onScrollToNext: () => _scrollToSection('about'),
                      ).animate().fadeIn(duration: AppAnimations.verySlow),
                      
                      // About Section
                      AboutSection()
                          .animate(delay: 200.ms)
                          .fadeIn(duration: AppAnimations.slow)
                          .slideY(begin: 50, end: 0),
                      
                      // Skills Section
                      SkillsSection()
                          .animate(delay: 400.ms)
                          .fadeIn(duration: AppAnimations.slow)
                          .slideY(begin: 50, end: 0),
                      
                      // Projects Section
                      ProjectsSection()
                          .animate(delay: 600.ms)
                          .fadeIn(duration: AppAnimations.slow)
                          .slideY(begin: 50, end: 0),
                      
                      // Experience Section
                      ExperienceSection()
                          .animate(delay: 800.ms)
                          .fadeIn(duration: AppAnimations.slow)
                          .slideY(begin: 50, end: 0),
                      
                      // Contact Section
                      ContactSection()
                          .animate(delay: 1000.ms)
                          .fadeIn(duration: AppAnimations.slow)
                          .slideY(begin: 50, end: 0),
                    ]),
                  ),
                ],
              ),
              
              // Desktop Navigation - Removed duplicate AppNavigation
              
              // Floating Action Button for scroll to top
              if (_scrollController.hasClients && _scrollController.offset > 1000)
                Positioned(
                  bottom: 32,
                  right: 32,
                  child: FloatingActionButton(
                    onPressed: () => _scrollToSection('home'),
                    backgroundColor: AppTheme.primaryColor,
                    child: const Icon(Icons.arrow_upward, color: Colors.white),
                  ).animate().scale(
                    duration: AppAnimations.normal,
                    curve: AppAnimations.bounceCurve,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
