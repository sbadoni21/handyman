import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/screens/login_page.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpPage extends ConsumerStatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  File? _userImage;
  String? _selectedDate;
  bool isLoading = false;

  final GlobalKey<FormState> _firstPageKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondPageKey = GlobalKey<FormState>();
  int _currentPage = 1;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _selectImage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      if (await Permission.storage.request().isGranted) {
        final XFile? pickedFile = await _imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );
        if (pickedFile != null) {
          setState(() {
            _userImage = File(pickedFile.path);
          });
        }
      } else {
        print('Permission denied by the user.');
      }
    } else {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _userImage = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> _submitFirstPage() async {
    if (_firstPageKey.currentState?.validate() ?? false) {
      setState(() {
        _currentPage = 2;
      });
    }
  }

  Future<void> _submitForm() async {
      setState(() {
      isLoading = true;
    });
    if (_secondPageKey.currentState?.validate() ?? false) {
     User? user =
          await ref.read(userStateNotifierProvider.notifier).signInWithEmail(
                name: fullNameController.text,
                email: emailController.text,
                password: passwordController.text,
                location: locationController.text,
                userImage: _userImage,
                dob: dateOfBirthController.text,


              );

      if (user != null) {
           setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        SnackBar(
            content: Dialog(
          child: Text("Error has been encountered"),
        ));
      }

      fullNameController.clear();
      locationController.clear();
      emailController.clear();
      passwordController.clear();
      retypePasswordController.clear();
      _userImage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _currentPage == 1 ? _firstPageKey : _secondPageKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/logoblack.png",
                        fit: BoxFit.contain,
                        height: 230,
                      ),
                      Center(
                        child: Text(
                          "Handy Hands",
                          style: TextStyle(
                            color: bgColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Container(
                  //   width: double.infinity,
                  //   child: Text(
                  //     _currentPage == 1 ? "Page - 1" : "Page - 2",
                  //     style: TextStyle(
                  //         color: bgColor,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  // ),

                  _currentPage == 1
                      ? _buildFirstPageFields()
                      : _buildSecondPageFields(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        _currentPage == 1 ? _submitFirstPage : _submitForm,
                    child: Text(
                      _currentPage == 1 ? "Next" : "Submit",
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5.0,
                      backgroundColor: bgColor, 
                      foregroundColor: Colors.white, 
                      padding: EdgeInsets.symmetric(
                          horizontal: 45.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
                      "Signup using google",
                      style: TextStyle(color: bgColor),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
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
                        child: Text('Sign In')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPageFields() {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildTextField(
          controller: fullNameController,
          labelText: 'Full Name',
          hintText: 'Enter your full name',
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: locationController,
          labelText: 'Location',
          hintText: 'Enter your location',
          icon: Icons.location_city,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: dateOfBirthController,
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (selectedDate != null) {
              setState(() {
                _selectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
                dateOfBirthController.text = _selectedDate!;
              });
            }
          },
          decoration: InputDecoration(
            labelText: 'Date of Birth (dd/mm/yyyy)',
            hintText: 'Enter your date of birth',
            prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your date of birth';
            }
            try {
              DateFormat('dd/MM/yyyy').parseStrict(value);
              return null;
            } catch (e) {
              return 'Invalid date format (dd/mm/yyyy)';
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: _selectImage,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: _userImage != null
                ? Image.file(
                    _userImage!,
                    fit: BoxFit.cover,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.blue),
                      Text('Select Image'),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondPageFields() {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildTextField(
          controller: emailController,
          labelText: 'Email',
          hintText: 'Enter your email',
          icon: Icons.email,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: passwordController,
          labelText: 'Password',
          hintText: 'Enter your password',
          icon: Icons.password,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: retypePasswordController,
          labelText: 'Retype Password',
          hintText: 'Retype your password',
          icon: Icons.password,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentPage = 1;
                });
              },
              child: const Text('Previous'),
              style: TextButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white, // Background color
                foregroundColor: bgColor, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        } else if (labelText == 'Email' &&
            !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                .hasMatch(value)) {
          return 'Please enter a valid email address';
        } else if (labelText == 'Password' && value.length < 6) {
          return 'Password must be at least 6 characters';
        } else if (labelText == 'Retype Password' &&
            value != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}
