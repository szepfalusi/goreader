import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    title: const Text(
      'GoReader',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    ),
    backgroundColor: Colors.green[800],
    elevation: 6,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10),
      ),
    ),
    toolbarHeight: 60,
  );
}
