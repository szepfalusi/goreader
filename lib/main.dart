import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goreader/screens/found_tag_screen.dart';
import 'package:goreader/screens/main_menu_screen.dart';
import 'package:goreader/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import './widgets/custom_app_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoReader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          backgroundColor: Colors.grey[50],
        ),
        textTheme: GoogleFonts.overpassTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            textStyle: const TextStyle(fontSize: 20),
            minimumSize: const Size(250, 40),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
      ),
      home: MainMenuScreen(),
      routes: {
        FoundTagScreen.routeName: (ctx) => FoundTagScreen(),
      },
    );
  }
}
