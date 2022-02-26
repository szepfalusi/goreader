import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goreader/helpers/authentication_helper.dart';
import 'package:goreader/helpers/nfc_helper.dart';
import 'package:goreader/models/tags.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:goreader/screens/login_screen.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:provider/provider.dart';

import '../widgets/custom_app_bar.dart';
import 'signup_screen.dart';
import 'found_tag_screen.dart';
import 'my_tags_screen.dart';
import 'profile_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = AuthenticationHelper.isAuthenticated;
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
            isAuthenticated
                ? ElevatedButton(
                    onPressed: () async {
                      await Provider.of<Tags>(context, listen: false)
                          .getTagsFromAPI();
                      Navigator.of(context).pushNamed(MyTagsScreen.routeName);
                    },
                    child: const Text('My tags'),
                  )
                : const ElevatedButton(onPressed: null, child: Text('My tags')),
            const SizedBox(height: 5),
            isAuthenticated
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                    child: const Text('My profile'),
                  )
                : ElevatedButton(onPressed: null, child: Text('My profile')),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                if (isAuthenticated) {
                  AuthenticationHelper().signOut();
                }
                Navigator.of(context).pushNamed(LogInScreen.routeName);
              },
              child: isAuthenticated
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
