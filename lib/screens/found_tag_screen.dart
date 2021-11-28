import 'package:flutter/material.dart';
import 'package:goreader/widgets/custom_app_bar.dart';

class FoundTagScreen extends StatefulWidget {
  static String routeName = '/found';
  const FoundTagScreen({Key? key}) : super(key: key);

  @override
  _FoundTagState createState() => _FoundTagState();
}

class _FoundTagState extends State<FoundTagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Találtam egy bilétát"),
    );
  }
}
