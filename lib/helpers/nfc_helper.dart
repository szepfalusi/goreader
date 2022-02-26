import 'package:flutter/foundation.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NfcHelper {
  Future readNfc() async {
    var tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 10),
        iosMultipleTagMessage: "Multiple tags found!",
        iosAlertMessage: "Scan your tag");
    if (tag.ndefAvailable) {
      /// decoded NDEF records (see [ndef.NDEFRecord] for details)
      /// `UriRecord: id=(empty) typeNameFormat=TypeNameFormat.nfcWellKnown type=U uri=https://github.com/nfcim/ndef`
      var ndefRecords = await FlutterNfcKit.readNDEFRecords();
      var ndefString = ndefRecords[0].toString();
      return ndefString.split('text=')[1];
    } else {
      return 'Something went wrong';
    }
  }
}
