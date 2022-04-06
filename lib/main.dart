import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crytoapp/constants/Themes.dart';
import 'package:crytoapp/models/LocalStorage.dart';
import 'package:crytoapp/pages/HomePage.dart';
import 'package:crytoapp/pages/Login.dart';
import 'package:crytoapp/providers/market_provider.dart';
import 'package:crytoapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  MyApp({required this.theme});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png"),
          
        ],
      ),
      backgroundColor: Color.fromARGB(255, 246, 241, 95),
      nextScreen:const LoginScreen(),
      splashIconSize: 200,
      duration: 1000,
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: const Duration(seconds: 3),
      );
    
  }
}
