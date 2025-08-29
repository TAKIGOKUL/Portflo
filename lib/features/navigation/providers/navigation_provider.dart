import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  String _currentSection = 'home';
  bool _isMenuOpen = false;
  final List<String> _sections = ['home', 'about', 'skills', 'projects', 'experience', 'contact'];

  int get currentIndex => _currentIndex;
  String get currentSection => _currentSection;
  bool get isMenuOpen => _isMenuOpen;
  List<String> get sections => List.unmodifiable(_sections);

  void setCurrentIndex(int index) {
    if (index >= 0 && index < _sections.length) {
      _currentIndex = index;
      _currentSection = _sections[index];
      notifyListeners();
    }
  }

  void setCurrentSection(String section) {
    if (_sections.contains(section)) {
      _currentSection = section;
      _currentIndex = _sections.indexOf(section);
      notifyListeners();
    }
  }

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }

  void closeMenu() {
    if (_isMenuOpen) {
      _isMenuOpen = false;
      notifyListeners();
    }
  }

  void openMenu() {
    if (!_isMenuOpen) {
      _isMenuOpen = true;
      notifyListeners();
    }
  }

  void navigateToSection(String section) {
    setCurrentSection(section);
    closeMenu();
  }

  void navigateToIndex(int index) {
    setCurrentIndex(index);
    closeMenu();
  }

  String getSectionDisplayName(String section) {
    switch (section) {
      case 'home':
        return 'Home';
      case 'about':
        return 'About';
      case 'skills':
        return 'Skills';
      case 'projects':
        return 'Projects';
      case 'experience':
        return 'Experience';
      case 'contact':
        return 'Contact';
      default:
        return section.toUpperCase();
    }
  }

  IconData getSectionIcon(String section) {
    switch (section) {
      case 'home':
        return Icons.home_outlined;
      case 'about':
        return Icons.person_outline;
      case 'skills':
        return Icons.code_outlined;
      case 'projects':
        return Icons.work_outline;
      case 'experience':
        return Icons.timeline_outlined;
      case 'contact':
        return Icons.contact_mail_outlined;
      default:
        return Icons.circle_outlined;
    }
  }
}
