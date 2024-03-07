import 'package:flutter/material.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/screens/infoscreen.dart';
import 'package:handyman/screens/sign_up_page.dart';
import 'package:handyman/services/auth/authentication.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthenticationServices authenticationService = AuthenticationServices();
  String? _selectedDate;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    var calendarStatus = await Permission.calendarWriteOnly.status;
    if (!calendarStatus.isGranted) {
      await Permission.calendarWriteOnly.request();
    }

    var audioStatus = await Permission.audio.status;
    if (!audioStatus.isGranted) {
      await Permission.audio.request();
    }

    var locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      await Permission.location.request();
    }

    var contactStatus = await Permission.contacts.status;
    if (!contactStatus.isGranted) {
      await Permission.contacts.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 150, 16, 16),
        child: ListView(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logoblack.png",
                    fit: BoxFit.cover,
                    height: 230,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: bgColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: bgColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 14.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: bgColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ResetPasswordPage(),
                //       ),
                //     );
                //   },
                //   style: TextButton.styleFrom(
                //     foregroundColor: Colors.black87,
                //   ),
                //   child: Container(
                //     width: double.infinity,
                //     child: const Text(
                //       'Forgot password',
                //       textAlign: TextAlign.right,
                //       style: TextStyle(decoration: TextDecoration.underline),
                //     ),
                //   ),
                // ),`
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isNotEmpty && password.isNotEmpty) {
                      setState(() {
                        isLoading = false;
                      });
                      User? user = await ref
                          .read(userStateNotifierProvider.notifier)
                          .signIn(email, password);
                      if (user != null) {
                        setState(() {
                          isLoading = false;
                        });
                        if (ref
                            .read(authenticationServicesProviderr)
                            .isFirstSignUp) {
                          // Navigate to the app info screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoScreen()),
                          );
                        } else {
                          // Navigate to the home screen or another screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }

                        // Reset the isFirstSignUp flag after navigation
                        ref.read(authenticationServicesProvider).isFirstSignUp =
                            false;
                        ;
                        print('Login successful');
                      } else {
                        print('Login failed');
                      }
                    } else {
                      print('Please enter email and password');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    backgroundColor: bgColor, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding:
                        EdgeInsets.symmetric(horizontal: 45.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: isLoading == true
                      ? CircularProgressIndicator()
                      : Text('Login'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    User? user = await ref
                        .read(userStateNotifierProvider.notifier)
                        .signInWithGoogle();
                    if (user != null) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                      print('Login with Google successful');
                    } else {
                      print('Login with Google failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: bgColor,
                    elevation: 5.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/images/google.png",
                      width: 32.0,
                      height: 32.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    "login using google",
                    style: TextStyle(color: bgColor),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor: Colors.white, // Text color
                    side: BorderSide(color: bgColor), // Border color
                  ),
                  child: Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: Text('Sign Up')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
