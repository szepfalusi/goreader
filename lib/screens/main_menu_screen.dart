import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goreader/models/tags.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:provider/provider.dart';

import '../widgets/custom_app_bar.dart';
import 'found_tag_screen.dart';
import 'my_tags_screen.dart';
import 'profile_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("GoReader"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                readNfc();
                Navigator.of(context).pushNamed(FoundTagScreen.routeName);
              },
              child: const Text('I found a tag'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<Tags>(context, listen: false)
                    .getTagsFromAPI();
                Navigator.of(context).pushNamed(MyTagsScreen.routeName);
              },
              child: const Text('My tags'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              child: const Text('My profile'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Log out'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void readNfc() async {
    var tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 10),
        iosMultipleTagMessage: "Multiple tags found!",
        iosAlertMessage: "Scan your tag");
    if (tag.ndefAvailable) {
      /// decoded NDEF records (see [ndef.NDEFRecord] for details)
      /// `UriRecord: id=(empty) typeNameFormat=TypeNameFormat.nfcWellKnown type=U uri=https://github.com/nfcim/ndef`
      var ndefRecords = await FlutterNfcKit.readNDEFRecords();
      var ndefString = ndefRecords[0].toString();
      if (kDebugMode) {
        print(ndefString.split('text=')[1]);
      }
    }
  }

  void writeNfc(String id) async {
    var tag = await FlutterNfcKit.poll();
    try {
      await FlutterNfcKit.writeNDEFRecords(
          [ndef.TextRecord(language: 'en', text: id)]);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // decoded NDEF records
  }
}
