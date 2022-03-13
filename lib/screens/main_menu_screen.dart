import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:goreader/models/custom_user.dart';
import 'package:goreader/models/custom_user_provider.dart';
import '../helpers/authentication_helper.dart';
import '../helpers/nfc_helper.dart';
import '../models/tags.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_app_bar.dart';
import 'found_tag_screen.dart';
import 'my_tags_screen.dart';
import 'profile_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);
  static const routeName = '/main-menu';

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final isAuthenticated = false;
    final nfcHelper = NfcHelper();

    return Scaffold(
      appBar: customAppBar("GoReader"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FoundTagScreen.routeName);
              },
              child: const Text('I found a tag'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                if (AuthenticationHelper().userId == null) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please log in to use this feature.')));
                  return;
                }
                Navigator.of(context).pushNamed(MyTagsScreen.routeName);
              },
              child: const Text('My tags'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                final userId = AuthenticationHelper().userId;
                if (userId == null) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please log in to use this feature.'),
                    ),
                  );
                  return;
                }

                await Provider.of<CustomUserProvider>(context, listen: false)
                    .getUserFromAPI();
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              child: const Text('My profile'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                if (AuthenticationHelper().userId != null) {
                  AuthenticationHelper().signOut();
                  setState(() {});
                }
                Navigator.of(context)
                    .pushNamed(LogInScreen.routeName)
                    .then((value) => setState(() {}));
              },
              child: AuthenticationHelper().userId != null
                  ? const Text('Sign out')
                  : const Text('Log in'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
