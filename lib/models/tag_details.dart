import 'package:flutter/foundation.dart';

class TagDetails extends ChangeNotifier {
  final String id;
  final String note;
  final String imageUrl;
  final String userId;

  TagDetails({
    required this.id,
    required this.note,
    required this.imageUrl,
    required this.userId,
  });
}
