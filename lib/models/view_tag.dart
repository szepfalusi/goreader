class ViewTag {
  final String tagName;
  final String note;
  final String imageUrl;
  final String userName;
  final String userAddress;
  final String userPhone;
  final String userNote;

  ViewTag({
    this.tagName = '',
    this.note = '',
    this.imageUrl = '',
    this.userName = '',
    this.userAddress = '',
    this.userPhone = '',
    this.userNote = '',
  });

  bool isEmpty() {
    if (tagName == '' &&
        note == '' &&
        imageUrl == '' &&
        userName == '' &&
        userAddress == '' &&
        userPhone == '' &&
        userNote == '') {
      return true;
    } else {
      return false;
    }
  }
}
