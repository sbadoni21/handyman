class User {
  final String deviceToken;
  final String displayName;
  final String email;
  final String photoURL;
  final String referralCode;
  final String status;
  final String uid;
  final String type;
  final bool isGoogleUser;
  final num wallet;
  final String dob;
  final String location;
  final List? myContest;

  User({
    required this.deviceToken,
    required this.displayName,
    required this.email,
    required this.isGoogleUser,
    required this.photoURL,
    required this.referralCode,
    required this.status,
    required this.uid,
    required this.type,
    required this.wallet,
    required this.location,
    required this.dob,
    required this.myContest,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      deviceToken: map['deviceToken'] ?? '',
      displayName: map['name'] ?? '',
      email: map['email'] ?? '',
      isGoogleUser:map['isGoogleUser']?? false,
      photoURL: map['photo'] ?? '',
      referralCode: map['referralCode'] ?? '',
      status: map['status'] ?? '',
      uid: map['uid'] ?? '',
      dob: map['DOB'] ?? "",
      wallet: map['wallet']?? "",
      type: map['type'] ?? "",
      location: map['location'] ?? "",
      myContest: List<String>.from(map['myContest'] ?? []),
    );
  }
}



