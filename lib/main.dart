import 'package:crytoapp/constants/Themes.dart';
import 'package:crytoapp/models/LocalStorage.dart';
import 'package:crytoapp/pages/HomePage.dart';
import 'package:crytoapp/providers/market_provider.dart';
import 'package:crytoapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            home: HomePage(),
          );
        },
      ),
    );
  }
}
