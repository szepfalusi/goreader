class Tag {
  final String id;
  final String name;
  final String note;
  final String imageUrl;
  final bool visibleName;
  final bool visibleAddress;
  final bool visiblePhone;
  final bool visibleNote;
  final String userId;

  Tag({
    required this.id,
    required this.name,
    required this.note,
    required this.imageUrl,
    required this.visibleName,
    required this.visibleAddress,
    required this.visiblePhone,
    required this.visibleNote,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'note': note,
        'imageUrl': imageUrl,
        'visibleName': visibleName,
        'visibleAddress': visibleAddress,
        'visiblePhone': visiblePhone,
        'visibleNote': visibleNote,
      };
  Tag setIdFromFirebase(String id, Tag tag) {
    return Tag(
        id: id,
        name: tag.name,
        note: tag.note,
        imageUrl: tag.imageUrl,
        userId: tag.userId,
        visibleAddress: tag.visibleAddress,
        visibleName: tag.visibleName,
        visibleNote: tag.visibleNote,
        visiblePhone: tag.visiblePhone);
  }
}
