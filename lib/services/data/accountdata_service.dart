import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman/models/user.dart';

class AccountService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future changeUserInfo(User user, String newName) async {
    try {
      if (newName != user.displayName) {
        await _firestore
            .collection("users")
            .doc(user.uid)
            .update({'name': newName});
      }
    } catch (e) {
      SnackBar(
        content: Text('Error while changing name'),
      );
    }
  }
}
