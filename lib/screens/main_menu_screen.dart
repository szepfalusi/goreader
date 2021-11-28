import 'package:flutter/material.dart';
import 'package:goreader/widgets/custom_app_bar.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'found_tag_screen.dart';

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
              child: const Text('Találtam egy bilétát'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Bilétáim'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Kijelentkezés'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }

  void readNfc() async {
    // Check availability
    bool isAvailable = await NfcManager.instance.isAvailable();
    print(isAvailable);
    // Start Session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        print(tag);
      },
    );

    // Stop Session
    NfcManager.instance.stopSession();
  }
}
