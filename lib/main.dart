import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/providers/theme_provider.dart';
import 'features/navigation/providers/navigation_provider.dart';
import 'features/home/pages/portfolio_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.darkBackground,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ScreenUtilInit(
            designSize: const Size(390, 844), // iPhone 12 design size
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Portfolio - Responsive Flutter App',
                debugShowCheckedModeBanner: false,
                theme: _getThemeData(themeProvider.currentTheme),
                home: const PortfolioPage(),
                builder: (context, widget) {
                  // Ensure text doesn't scale beyond reasonable limits
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(
                        MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.2),
                      ),
                    ),
                    child: widget!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  ThemeData _getThemeData(dynamic theme) {
    switch (theme) {
      case CustomTheme.noctis:
        return AppTheme.getNoctisTheme();
      case CustomTheme.sublimeGit:
        return AppTheme.getSublimeGitTheme();
      case CustomTheme.dark:
        return AppTheme.darkTheme;
      case CustomTheme.light:
        return AppTheme.lightTheme;
      default:
        return AppTheme.getNoctisTheme();
    }
  }
}