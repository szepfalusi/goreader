import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/custom_user.dart';
import 'models/custom_user_provider.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/tags.dart';
import 'screens/found_tag_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/my_tags_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/tag_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Tags(),
        ),
        ChangeNotifierProvider.value(
          value: CustomUserProvider(),
        ),
      ],
      child: MaterialApp(
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
        localizationsDelegates: [FormBuilderLocalizations.delegate],
        home: const MainMenuScreen(),
        routes: {
          FoundTagScreen.routeName: (ctx) => FoundTagScreen(),
          MyTagsScreen.routeName: (ctx) => MyTagsScreen(),
          TagFormScreen.routeName: (ctx) => TagFormScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          LogInScreen.routeName: (ctx) => LogInScreen(),
        },
      ),
    );
  }
}
