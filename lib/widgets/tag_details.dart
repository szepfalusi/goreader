import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goreader/models/tag.dart';
import 'package:goreader/models/view_tag.dart';
import 'package:goreader/screens/found_tag_screen.dart';
import 'package:goreader/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../models/tags.dart';

TagDetails(BuildContext context, ViewTag tag, String error) {
  if (!tag.isEmpty()) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                tag.tagName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 4),
          tag.imageUrl != ''
              ? Image.network(
                  tag.imageUrl,
                  width: 250,
                  height: 250,
                )
              : Image.asset('assets/nfc.png'),
          const SizedBox(height: 4),
          Center(child: Text('Note for this tag: \n' + tag.note)),
          const SizedBox(height: 8),
          const Text(
            'Tag owner\'s data:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          tag.userName != ''
              ? Text('Name: \n' + tag.userName)
              : const Text('Name is private, or the owner doesn\'t filled it.'),
          const SizedBox(height: 4),
          tag.userAddress != ''
              ? Text('Address: \n' + tag.userAddress)
              : const Text(
                  'Address is private, or the owner doesn\'t filled it.'),
          const SizedBox(height: 4),
          tag.userPhone != ''
              ? Text('Phone number: \n' + tag.userPhone)
              : const Text(
                  'Phone number is private, or the owner doesn\'t filled it.'),
          const SizedBox(height: 4),
          tag.userNote != ''
              ? Text('Note: \n' + tag.userAddress)
              : const Text('Note is private, or the owner doesn\'t filled it.'),
        ],
      ),
    );
  } else {
    switch (error) {
      case 'no-nfc':
        return const Center(
          child: Text('Please enable NFC on this device'),
        );
      case 'no-goreader':
        return const Center(
          child: Text(
              'This tag isn\'t a GoReader tag. If it is, please contact us.'),
        );
      case 'timeout':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('Hmm, we didn\'t find any tag, please try again.'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => FoundTagScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                child: const Text('Try again'))
          ],
        );
      default:
        return const Center(
          child: Text('Unknown error, please contact us.'),
        );
    }
  }
}
