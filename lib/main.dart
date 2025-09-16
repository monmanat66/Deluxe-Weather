import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/forecast_provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorSeed = const Color(0xFF6C63FF);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ForecastProvider()..load()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Deluxe Weather',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: colorSeed,
          textTheme: GoogleFonts.promptTextTheme(),
          scaffoldBackgroundColor: const Color(0xFFF5F6FB),
          cardTheme: const CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
