import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handyman/services/notification/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

final authenticationServicesProviderr = Provider<AuthenticationServices>((ref) {
  return AuthenticationServices();
});

class AuthenticationServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool isFirstSignUp = false;
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error during sign-in: $e");
      return null;
    }
  }

  static String verifyId = "";

  Future<void> sentOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await FirebaseAuth.instance
        .verifyPhoneNumber(
      timeout: Duration(seconds: 30),
      phoneNumber: "+91$phone",
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  Future<User?> loginWithOtp({required String otp}) async {
    try {
      final cred =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(cred);
      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;
        bool userExists = await _userExists(uid);

        if (!userExists) {
          isFirstSignUp = true;
          final email = userCredential.user!.providerData[0].email;
          final displayName = userCredential.user!.displayName;
          final status = 'active';
          final photoURL = userCredential.user!.photoURL;
          final coins = 0;
          final type = "free";
          final isGoogleUser = true;
          final referralCode = randomAlphaNumeric(8);
          const wallet = 0;
          const dob = '';
          final deviceToken = await NotificationService().getDeviceToken();

          await _fireStore.collection('users').doc(uid).set({
            'uid': uid,
            'email': email,
            'name': displayName,
            'status': 'active',
            'type': "free",
            'isGoogleUser': isGoogleUser,
            'location': "",
            'photo': photoURL ?? "none",
            'wallet': wallet,
            'referralCode': referralCode,
            'DOB': dob,
            'myOrders': [],
            'latitude': 0,
            'longitude': 0,
            'deviceToken': deviceToken,
            'myCart': [],
          });
        }

        var status = await Permission.location.status;
        if (!status.isGranted) {
          if (await Permission.location.request().isGranted) {
            Position? position = await Geolocator.getCurrentPosition();

            if (position != null) {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                position.latitude,
                position.longitude,
              );

              if (placemarks.isNotEmpty) {
                String city = placemarks[0].locality ?? "Unknown City";

                await _fireStore.collection('users').doc(uid).update({
                  'location': city,
                });
              }
            }
          }
        } else {
          Position? position = await Geolocator.getCurrentPosition();

          if (position != null) {
            List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude,
              position.longitude,
            );

            if (placemarks.isNotEmpty) {
              String city = placemarks[0].locality ?? "Unknown City";

              await _fireStore.collection('users').doc(uid).update({
                'location': city,
                'latitude': position.latitude,
                'longitude': position.longitude,
              });
            }
          }
        }

        return userCredential.user;
      }
    } catch (error) {
      print("Error during login: $error");
      return null;
    }
  }

  bool isGoogleUser() {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        return user.providerData
            .any((userInfo) => userInfo.providerId == 'google.com');
      }
    } catch (e) {
      print('Error checking if user signed up with Google: $e');
    }
    return false;
  }

  Future<bool> validateOTP(String otpEntered, String otpSent) async {
    return otpEntered == otpSent;
  }

  Future<bool> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('Failed to reset password: $e');
      return false;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        if (userCredential.user != null) {
          final uid = userCredential.user!.uid;
          bool userExists = await _userExists(uid);

          if (!userExists) {
            isFirstSignUp = true;
            final email = userCredential.user!.providerData[0].email;
            final displayName = userCredential.user!.displayName;
            final status = 'active';
            final photoURL = userCredential.user!.photoURL;
            final coins = 0;
            final type = "free";
            final isGoogleUser = true;
            final referralCode = randomAlphaNumeric(8);
            const wallet = 0;
            const dob = '';
            final deviceToken = await NotificationService().getDeviceToken();

            await _fireStore.collection('users').doc(uid).set({
              'uid': uid,
              'email': email,
              'name': displayName,
              'status': 'active',
              'type': "free",
              'isGoogleUser': isGoogleUser,
              'location': "",
              'photo': photoURL ?? "none",
              'wallet': wallet,
              'referralCode': referralCode,
              'DOB': dob,
              'myOrders': [],
              'latitude': 0,
              'longitude': 0,
              'deviceToken': deviceToken,
              'myCart': []
            });
          }

          var status = await Permission.location.status;
          if (!status.isGranted) {
            if (await Permission.location.request().isGranted) {
              Position? position = await Geolocator.getCurrentPosition();

              if (position != null) {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  position.latitude,
                  position.longitude,
                );

                if (placemarks.isNotEmpty) {
                  String city = placemarks[0].locality ?? "Unknown City";

                  await _fireStore.collection('users').doc(uid).update({
                    'location': city,
                  });
                }
              }
            }
          } else {
            Position? position = await Geolocator.getCurrentPosition();

            if (position != null) {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                position.latitude,
                position.longitude,
              );

              if (placemarks.isNotEmpty) {
                String city = placemarks[0].locality ?? "Unknown City";

                await _fireStore.collection('users').doc(uid).update({
                  'location': city,
                  'latitude': position.latitude,
                  'longitude': position.longitude
                });
              }
            }
          }

          return userCredential.user;
        }
      }
    } catch (e) {
      print('Failed to sign in with Google: $e');
    }

    return null;
  }

  Future<bool> _userExists(String uid) async {
    try {
      DocumentSnapshot document =
          await _fireStore.collection('users').doc(uid).get();
      return document.exists;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  Future<String?> getCurrentUserId() async {
    try {
      User? user = firebaseAuth.currentUser;

      if (user != null) {
        return user.uid;
      }
    } catch (e) {
      print('Failed to get current user ID: $e');
    }

    return null;
  }

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
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String? photoURL;
        isFirstSignUp = true;

        if (userImage != null) {
          final Reference userStorageReference = _storage.ref().child(
              'user_images/${userCredential.user!.uid}/${DateTime.now().millisecondsSinceEpoch}_user.png');
          final UploadTask userUploadTask =
              userStorageReference.putFile(userImage);
          await userUploadTask.whenComplete(() async {
            photoURL = await userStorageReference.getDownloadURL();
          });
        }
        final List myCourses = [];
        final num wallet = 0;
        final referralCode = randomAlphaNumeric(8);
        final deviceToken = await NotificationService().getDeviceToken();

        await _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'name': name,
          'status': 'active',
          'type': "free",
          'isGoogleUser': false,
          'location': "",
          'photo': photoURL ?? "none",
          'wallet': wallet,
          'referralCode': referralCode,
          'myOrders': [],
          'DOB': dob,
          'latitude': 0,
          'longitude': 0,
          'deviceToken': deviceToken,
          'myCart': []
        }, SetOptions(merge: true));
        var status = await Permission.location.status;
        if (!status.isGranted) {
          if (await Permission.location.request().isGranted) {
            Position? position = await Geolocator.getCurrentPosition();

            if (position != null) {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                position.latitude,
                position.longitude,
              );

              if (placemarks.isNotEmpty) {
                String city = placemarks[0].locality ?? "Unknown City";

                await _fireStore
                    .collection('users')
                    .doc(userCredential.user!.uid)
                    .update({
                  'location': city,
                  'latitude': position.latitude,
                  'longitude': position.longitude
                });
              }
            }
          }
        } else {
          Position? position = await Geolocator.getCurrentPosition();

          if (position != null) {
            List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude,
              position.longitude,
            );

            if (placemarks.isNotEmpty) {
              String city = placemarks[0].locality ?? "Unknown City";

              await _fireStore
                  .collection('users')
                  .doc(userCredential.user!.uid)
                  .update({
                'location': city,
                'latitude': position.latitude,
                'longitude': position.longitude
              });
            }
          }
        }
        return userCredential.user;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }

    return null;
  }

  Future changeUserInfo(String userID, String newName) async {
    try {
      await _fireStore
          .collection("users")
          .doc(userID)
          .update({'name': newName});
    } catch (e) {
      SnackBar(
        content: Text('Error while changing name'),
      );
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
