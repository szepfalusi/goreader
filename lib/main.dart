import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          textTheme: GoogleFonts.overpassTextTheme()),
      home: Scaffold(
        appBar: customAppBar(),
        body: const Center(
          child: Text('Üdv'),
        ),
      ),
    );
  }
}
