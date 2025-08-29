import 'package:flutter/material.dart';

class ResponsiveBreakpoints {
  static const double mobileSmall = 480;
  static const double mobile = 768;
  static const double tablet = 1024;
  static const double desktop = 1280;
  static const double desktopLarge = 1440;
  static const double ultraWide = 1920;
}

enum DeviceType { mobileSmall, mobile, tablet, desktop, desktopLarge, ultraWide }

class ResponsiveUtils {
  /// Get the current device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width <= ResponsiveBreakpoints.mobileSmall) {
      return DeviceType.mobileSmall;
    } else if (width <= ResponsiveBreakpoints.mobile) {
      return DeviceType.mobile;
    } else if (width <= ResponsiveBreakpoints.tablet) {
      return DeviceType.tablet;
    } else if (width <= ResponsiveBreakpoints.desktop) {
      return DeviceType.desktop;
    } else if (width <= ResponsiveBreakpoints.desktopLarge) {
      return DeviceType.desktopLarge;
    } else {
      return DeviceType.ultraWide;
    }
  }

  /// Check if device is mobile (768px and below)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= ResponsiveBreakpoints.mobile;
  }

  /// Check if device is tablet (768px - 1024px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > ResponsiveBreakpoints.mobile && 
           width <= ResponsiveBreakpoints.tablet;
  }

  /// Check if device is desktop (1024px and above)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > ResponsiveBreakpoints.tablet;
  }

  /// Get responsive padding based on device type
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case DeviceType.mobile:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
      case DeviceType.tablet:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
      case DeviceType.desktop:
        return const EdgeInsets.symmetric(horizontal: 48, vertical: 32);
      case DeviceType.desktopLarge:
        return const EdgeInsets.symmetric(horizontal: 64, vertical: 40);
      case DeviceType.ultraWide:
        return const EdgeInsets.symmetric(horizontal: 80, vertical: 48);
    }
  }

  /// Get responsive content width
  static double getContentWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return screenWidth - 32; // Full width minus padding
      case DeviceType.tablet:
        return (screenWidth * 0.9).clamp(600.0, 900.0);
      case DeviceType.desktop:
        return (screenWidth * 0.8).clamp(900.0, 1200.0);
      case DeviceType.desktopLarge:
        return (screenWidth * 0.75).clamp(1000.0, 1400.0);
      case DeviceType.ultraWide:
        return (screenWidth * 0.7).clamp(1200.0, 1600.0);
    }
  }

  /// Get responsive grid columns for project cards
  static int getGridColumns(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return 1;
      case DeviceType.tablet:
        return 2;
      case DeviceType.desktop:
        return 3;
      case DeviceType.desktopLarge:
      case DeviceType.ultraWide:
        return 4;
    }
  }

  /// Get responsive font size multiplier
  static double getFontSizeMultiplier(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
        return 0.85;
      case DeviceType.mobile:
        return 0.9;
      case DeviceType.tablet:
        return 1.0;
      case DeviceType.desktop:
        return 1.1;
      case DeviceType.desktopLarge:
        return 1.2;
      case DeviceType.ultraWide:
        return 1.3;
    }
  }

  /// Get responsive minimum height functions
  static double getMinHeight(BuildContext context, double baseHeight) {
    final width = MediaQuery.of(context).size.width;
    
    if (width <= ResponsiveBreakpoints.mobileSmall) {
      return baseHeight * 0.8;
    } else if (width <= ResponsiveBreakpoints.mobile) {
      return baseHeight * 0.9;
    } else {
      return baseHeight;
    }
  }

  /// Get responsive spacing
  static double getSpacing(BuildContext context, double baseSpacing) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
        return baseSpacing * 0.75;
      case DeviceType.mobile:
        return baseSpacing;
      case DeviceType.tablet:
        return baseSpacing * 1.25;
      case DeviceType.desktop:
        return baseSpacing * 1.5;
      case DeviceType.desktopLarge:
        return baseSpacing * 1.75;
      case DeviceType.ultraWide:
        return baseSpacing * 2.0;
    }
  }

  /// Get responsive hero section height
  static double getHeroHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return screenHeight * 0.8;
      case DeviceType.tablet:
        return screenHeight * 0.85;
      case DeviceType.desktop:
      case DeviceType.desktopLarge:
      case DeviceType.ultraWide:
        return screenHeight * 0.9;
    }
  }

  /// Get responsive section padding
  static EdgeInsets getSectionPadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
        return const EdgeInsets.symmetric(vertical: 40, horizontal: 16);
      case DeviceType.mobile:
        return const EdgeInsets.symmetric(vertical: 50, horizontal: 20);
      case DeviceType.tablet:
        return const EdgeInsets.symmetric(vertical: 60, horizontal: 32);
      case DeviceType.desktop:
        return const EdgeInsets.symmetric(vertical: 80, horizontal: 48);
      case DeviceType.desktopLarge:
        return const EdgeInsets.symmetric(vertical: 100, horizontal: 64);
      case DeviceType.ultraWide:
        return const EdgeInsets.symmetric(vertical: 120, horizontal: 80);
    }
  }

  /// Get responsive card aspect ratio
  static double getCardAspectRatio(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return 1.2;
      case DeviceType.tablet:
        return 1.1;
      case DeviceType.desktop:
      case DeviceType.desktopLarge:
      case DeviceType.ultraWide:
        return 0.75;
    }
  }

  /// Get responsive navigation height
  static double getNavigationHeight(BuildContext context) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return 60;
      case DeviceType.tablet:
        return 70;
      case DeviceType.desktop:
      case DeviceType.desktopLarge:
      case DeviceType.ultraWide:
        return 80;
    }
  }

  /// Get responsive border radius
  static double getBorderRadius(BuildContext context, double baseRadius) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return baseRadius * 0.8;
      case DeviceType.tablet:
        return baseRadius;
      case DeviceType.desktop:
      case DeviceType.desktopLarge:
      case DeviceType.ultraWide:
        return baseRadius * 1.2;
    }
  }
}

/// Widget that builds different layouts for different device types
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.desktopLarge,
    this.ultraWide,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? desktopLarge;
  final Widget? ultraWide;

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveUtils.getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.desktopLarge:
        return desktopLarge ?? desktop ?? tablet ?? mobile;
      case DeviceType.ultraWide:
        return ultraWide ?? desktopLarge ?? desktop ?? tablet ?? mobile;
    }
  }
}

/// Responsive value class that returns different values for different device types
class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.desktopLarge,
    this.ultraWide,
  });

  final T mobile;
  final T? tablet;
  final T? desktop;
  final T? desktopLarge;
  final T? ultraWide;

  T getValue(BuildContext context) {
    final deviceType = ResponsiveUtils.getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobileSmall:
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.desktopLarge:
        return desktopLarge ?? desktop ?? tablet ?? mobile;
      case DeviceType.ultraWide:
        return ultraWide ?? desktopLarge ?? desktop ?? tablet ?? mobile;
    }
  }
}
