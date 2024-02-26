import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class signup_service {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<User?> registerUser({
    required String name,
    required String email,
    required String password,
    required String location,
    required String dob,
    File? userImage,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String? photoURL;
        if (userImage != null) {
          final Reference storageReference = _storage.ref().child(
              'user_images/${userCredential.user!.uid}/${DateTime.now().millisecondsSinceEpoch}.png');
          final UploadTask uploadTask = storageReference.putFile(userImage);
          await uploadTask.whenComplete(() async {
            photoURL = await storageReference.getDownloadURL();
          });
        }
        final referralCode = randomAlphaNumeric(8);
        const wallet = 0;
        await _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'name': name,
          'status': 'active',
          'photo': photoURL ?? "none",
          'type': "free",
          'dob': dob,
          'location': location,
          'isGoogleUser': false,
          'referralCode': referralCode,
          'wallet': wallet,
          'myContests': [],
        }, SetOptions(merge: true));

        return userCredential.user;
      }
    } catch (e) {
      return null;
    }
  }
}
