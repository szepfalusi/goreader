import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../helpers/nfc_helper.dart';
import '../models/tags.dart';
import '../models/view_tag.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/tag_details.dart';

class FoundTagScreen extends StatefulWidget {
  static String routeName = '/found';
  const FoundTagScreen({Key? key}) : super(key: key);

  @override
  _FoundTagState createState() => _FoundTagState();
}

class _FoundTagState extends State<FoundTagScreen> {
  final nfcHelper = NfcHelper();
  ViewTag tag = ViewTag();
  bool isRead = false;
  String errorMessage = '';

  @override
  void initState() {
    tag = ViewTag();
    isRead = false;
    errorMessage = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isRead) {
      nfcHelper.readNfc().then((value) {
        log('nfc value: ' + value);
        if (value != 'try-again') {
          Provider.of<Tags>(context, listen: false)
              .findTagFromFirebase(value)
              .then((el) {
            if (el.isEmpty()) {
              errorMessage = 'no-goreader';
            }
            setState(() {
              tag = el;
              isRead = true;
            });
          });
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
        final tempErr = error as PlatformException;
        if (tempErr.code == '404') {
          log('nonfc');
          setState(() {
            errorMessage = 'no-nfc';
          });
        }
        if (tempErr.code == '408') {
          setState(() {
            errorMessage = 'timeout';
          });
        }
        isRead = true;
      });
    }

    return Scaffold(
      appBar: customAppBar("I found a tag"),
      body: isRead
          ? tagDetails(context, tag, errorMessage)
          : const Center(child: Text('Please scan your tag.')),
    );
  }
}
