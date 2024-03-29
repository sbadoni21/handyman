import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/cart_screen.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/screens/search_page.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomAppBar({
    Key? key,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: SizedBox(
        height: preferredSize.height,
        child: Image.asset(
          'assets/images/logowhite.png',
          fit: BoxFit.contain,
        ),
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          if (widget.scaffoldKey != null) {
          } else {
            Navigator.pop(context);
          }
        },
        child: widget.scaffoldKey != null
            ? SizedBox()
            : const Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Ionicons.cart_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
        ),
      ],
    );
  }

  void _showWalletBottomSheet(BuildContext context) {
    User? user = ref.watch(userStateNotifierProvider);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: const LinearGradient(
                        colors: [Colors.black, Color(0xFFACABB0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Current Balance :',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '₹ ${user!.wallet}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Navigator.pop(context);
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     foregroundColor: Colors.blue,
                        //     backgroundColor: Colors.white,
                        //   ),
                        //   child: const Text('Add Money'),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
