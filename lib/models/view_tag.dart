class ViewTag {
  final String tagName;
  final String note;
  final String imageUrl;
  final String userName;
  final String userAddress;
  final String userPhone;
  final String userNote;
  final String email;

  ViewTag({
    this.tagName = '',
    this.note = '',
    this.imageUrl = '',
    this.userName = '',
    this.userAddress = '',
    this.userPhone = '',
    this.userNote = '',
    this.email = '',
  });

  bool isEmpty() {
    if (tagName == '' &&
        note == '' &&
        imageUrl == '' &&
        userName == '' &&
        userAddress == '' &&
        userPhone == '' &&
        userNote == '' &&
        email == '') {
      return true;
    } else {
      return false;
    }
  }
}
