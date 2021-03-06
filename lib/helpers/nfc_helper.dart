import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

class NfcHelper {
  Future readNfc() async {
    var tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 4),
        iosMultipleTagMessage: "Multiple tags found!",
        iosAlertMessage: "Scan your tag");
    if (tag.ndefAvailable) {
      var ndefRecords = await FlutterNfcKit.readNDEFRecords();
      if (ndefRecords.isNotEmpty) {
        var ndefString = ndefRecords[0].toString();
        return ndefString.split('text=')[1];
      } else {
        return 'try-again';
      }
    } else {
      return 'try-again';
    }
  }

  Future writeNfc(String tagId) async {
    var tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 10),
        iosMultipleTagMessage: "Multiple tags found!",
        iosAlertMessage: "Scan your tag to write");
    if (tag.ndefAvailable) {
      await FlutterNfcKit.writeNDEFRecords([
        ndef.TextRecord(language: 'en', text: tagId),
        ndef.UriRecord.fromString(
            'http://goreader.szepfalusi.hu/?tagId=' + tagId)
      ]);
    } else {
      return 'Something went wrong';
    }
  }
}
