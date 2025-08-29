# Responsive Portfolio Flutter App

A modern, responsive portfolio Flutter application showcasing best practices from web development projects, built for Android, Web, and Linux platforms.

## ✨ Features

### 🎨 Design & UI
- **Modern Dark Theme** with gradient accents and smooth animations
- **Fully Responsive** design that works seamlessly across all devices
- **Professional Typography** using Google Fonts (Space Grotesk & Inter)
- **Smooth Animations** powered by flutter_animate
- **Glass morphism effects** and modern card designs
- **Interactive particle background** animations

### 📱 Platform Support
- **Android** - Optimized mobile experience
- **Web** - Progressive Web App with responsive design
- **Linux** - Native desktop application

### 🔧 Technical Features
- **Comprehensive Responsive System** with 6 breakpoints
- **State Management** using Provider pattern
- **Theme System** with dark/light mode support
- **Navigation** with smooth scrolling and section highlighting
- **Form Validation** with proper error handling
- **URL Launcher** for external links and contact actions
- **Optimized Performance** with proper widget lifecycle management

## 🏗️ Architecture

The project follows a clean, modular architecture:

```
lib/
├── core/                    # Core utilities and configurations
│   ├── constants/          # App constants and configuration
│   ├── responsive/         # Responsive design utilities
│   ├── theme/             # App theme and styling
│   └── utils/             # Utility functions and helpers
├── features/              # Feature-based modules
│   ├── about/             # About section
│   ├── contact/           # Contact form and information
│   ├── experience/        # Work experience timeline
│   ├── home/              # Hero section and main page
│   ├── navigation/        # Navigation components and logic
│   ├── projects/          # Projects showcase
│   └── skills/            # Skills and expertise
└── shared/                # Shared components and widgets
    └── widgets/           # Reusable UI components
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- For web: Chrome/Edge browser
- For Android: Android Studio/VS Code with Android SDK
- For Linux: Linux development environment

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd responsive_portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**

   For Web:
   ```bash
   flutter run -d web-server --web-port 8080
   ```

   For Android:
   ```bash
   flutter run -d android
   ```

   For Linux:
   ```bash
   flutter run -d linux
   ```

## 📋 Configuration

### Personal Information
Update your personal information in `lib/core/constants/app_constants.dart`:

```dart
// Personal Info
static const String name = 'Your Name';
static const String title = 'Your Job Title';
static const String email = 'your.email@example.com';
static const String phone = '+1 (555) 123-4567';
static const String location = 'Your Location';

// Social Links
static const String githubUrl = 'https://github.com/yourusername';
static const String linkedinUrl = 'https://linkedin.com/in/yourusername';
// ... more links
```

### Projects Data
Add your projects in the same constants file:

```dart
static const List<Map<String, dynamic>> projects = [
  {
    'id': '1',
    'title': 'Your Project Name',
    'description': 'Brief description...',
    'technologies': ['Flutter', 'Firebase', 'etc'],
    'githubUrl': 'https://github.com/your-project',
    'liveUrl': 'https://your-project.com',
    'featured': true,
    // ... more fields
  },
  // ... more projects
];
```

### Assets
1. **Profile Image**: Add your profile photo as `assets/images/profile.jpg`
2. **Project Images**: Add project screenshots to `assets/images/`
3. **Custom Fonts**: Add any custom fonts to `assets/fonts/`

## 🎯 Key Components

### Responsive System
The app uses a comprehensive responsive system with 6 breakpoints:
- **Mobile Small**: ≤ 480px
- **Mobile**: ≤ 768px  
- **Tablet**: ≤ 1024px
- **Desktop**: ≤ 1280px
- **Desktop Large**: ≤ 1440px
- **Ultra Wide**: > 1440px

### Navigation
- **Desktop**: Fixed top navigation with smooth scrolling
- **Mobile**: Hamburger menu with slide-out drawer
- **Auto-highlight**: Current section is automatically highlighted based on scroll position

### Animations
- **Page Load**: Staggered entrance animations
- **Hover Effects**: Interactive button and card hover states
- **Scroll Animations**: Elements animate in as they come into view
- **Background**: Subtle particle animation system

## 🔨 Customization

### Theme Colors
Modify colors in `lib/core/theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF00D9FF);
static const Color secondaryColor = Color(0xFF6C5CE7);
static const Color accentColor = Color(0xFFFF6B6B);
```

### Animation Timing
Adjust animation durations in `lib/core/utils/animations.dart`:

```dart
static const Duration fast = Duration(milliseconds: 200);
static const Duration normal = Duration(milliseconds: 300);
static const Duration slow = Duration(milliseconds: 500);
```

### Responsive Breakpoints
Modify breakpoints in `lib/core/responsive/responsive_utils.dart`:

```dart
class ResponsiveBreakpoints {
  static const double mobileSmall = 480;
  static const double mobile = 768;
  static const double tablet = 1024;
  // ... etc
}
```

## 📱 Platform-Specific Features

### Web
- **SEO Optimized**: Proper meta tags and structure
- **PWA Ready**: Can be installed as a Progressive Web App
- **Responsive**: Adapts to any screen size
- **Fast Loading**: Optimized bundle size and lazy loading

### Android
- **Material Design**: Follows Android design guidelines
- **Adaptive Icons**: Support for adaptive launcher icons
- **Deep Linking**: Support for custom URL schemes
- **Performance**: Optimized for mobile performance

### Linux
- **Native Feel**: Follows Linux desktop conventions
- **Window Management**: Proper window sizing and controls
- **Keyboard Navigation**: Full keyboard accessibility
- **Theme Integration**: Adapts to system theme preferences

## 🧪 Testing

Run tests with:
```bash
flutter test
```

For widget tests:
```bash
flutter test test/widget_test.dart
```

## 📦 Building for Production

### Web
```bash
flutter build web --release
```

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### Linux
```bash
flutter build linux --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Google Fonts** for beautiful typography
- **Flutter Animate** for smooth animations
- **Community Contributors** for inspiration and feedback

## 📞 Contact

- **Email**: your.email@example.com
- **LinkedIn**: [Your LinkedIn](https://linkedin.com/in/yourusername)
- **GitHub**: [Your GitHub](https://github.com/yourusername)
- **Portfolio**: [Your Portfolio](https://yourportfolio.com)

---

**Made with ❤️ using Flutter**