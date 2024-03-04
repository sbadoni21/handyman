import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/sidemenu_assets.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/login_page.dart';
import 'package:handyman/services/data/accountdata_service.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:handyman/widgets/heading_component.dart';
import 'package:ionicons/ionicons.dart';

final userProvider = Provider<User?>((ref) {
  return ref
      .watch(userStateNotifierProvider as AlwaysAliveProviderListenable<User?>);
});

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  TextEditingController changeNameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    changeNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    User? user = ref.watch(userProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Hi',
                    style: myTextStylefontsize16white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    user!.displayName,
                    style: myTextStylefontsize16white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildShowChangeName(),
                      );
                    },
                    icon: Icon(
                      Ionicons.pencil,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: sideMenuItems.map((asset) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      if (asset['text'] == 'Logout') {
                        ref.read(userStateNotifierProvider.notifier).signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => asset['route'],
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              asset['icon'],
                              key: Key(
                                asset['key'],
                              ),
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              asset['text'],
                              style: myTextStylefontsize14WhiteW400,
                            ),
                          ],
                        ),
                        Icon(
                          Ionicons.arrow_forward_circle_outline,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Made with  ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowChangeName() {
    User? user = ref.watch(userProvider);
    bool isLoading = true;
    return isLoading == false
        ? CircularProgressIndicator()
        : AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Change Name',
              style: myTextStylefontsize16Grey,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: changeNameTextController,
                  maxLength: 30,
                  decoration: InputDecoration(
                    labelText: 'New name...',
                    labelStyle: myTextStylefontsize14GreyW700,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await ref
                            .read(userStateNotifierProvider.notifier)
                            .changeUserInfo(changeNameTextController.text);
                        setState(() {
                          isLoading = false;
                        });
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Change',
                        style: myTextStylefontsize12Grey,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: myTextStylefontsize12Grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
