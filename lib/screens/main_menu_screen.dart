import 'dart:developer';

import 'package:flutter/material.dart';
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
                nfcHelper.readNfc();
                Navigator.of(context).pushNamed(FoundTagScreen.routeName);
              },
              child: const Text('I found a tag'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                if (AuthenticationHelper().userId == null) {
                  log('no access to tags');
                  return;
                }
                await Provider.of<Tags>(context, listen: false)
                    .getTagsFromAPI();
                Navigator.of(context).pushNamed(MyTagsScreen.routeName);
              },
              child: const Text('My tags'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                if (AuthenticationHelper().userId == null) {
                  return;
                }
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              child: const Text('My profile'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                if (AuthenticationHelper().userId != null) {
                  AuthenticationHelper().signOut();
                }
                Navigator.of(context).pushNamed(LogInScreen.routeName);
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
