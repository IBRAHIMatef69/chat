
class Users {
  final String displaydame;
  final String email;
  final String profUrl;
  final String uid;

  Users(this.displaydame, this.email, this.profUrl, this.uid);

  factory Users.fromJson(jsonData) {
    return Users(
      jsonData['displaydame'],
      jsonData["email"],
      jsonData["profUrl"],
      jsonData["uid"],
    );
  }
}
