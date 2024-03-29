import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/booknow_screen.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:ionicons/ionicons.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Icon(
                  Ionicons.cart_outline,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  "My Cart",
                  style: myTextStylefontsize24White,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: buildCartItems(),
          ),
          // buildTotalCostEstimated(),
        ],
      ),
    );
  }

  Widget buildCartItems() {
    User? user = ref.watch(userStateNotifierProvider);

    return Column(
      children: [
        ListView.builder(
          itemCount: user!.myCart?.length ?? 0,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            var cartItem = user.myCart![index];

            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: EdgeInsets.all(10),
              tileColor: Colors.white,
              title: Text(cartItem.serviceProviderName),
              titleAlignment: ListTileTitleAlignment.top,
              leadingAndTrailingTextStyle: myTextStylefontsize12Grey,
              leading: Image.network(cartItem.serviceProviderPhoto),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Ionicons.remove_circle_sharp,
                  color: Colors.red,
                ),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service Category: ${cartItem.serviceCategoryName}"),
                  Text("Service: ${cartItem.subCategoryServiceName}"),
                  Text('Cost: ${cartItem.cost}'),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => BookNowScreen(serviceProviderUID: cartItem.serviceProviderUID,serviceCategoryName: cartItem.serviceCategoryName, serviceCategoryUID: cartItem.serviceCategoryUID ,serviceProviderName: cartItem.serviceProviderName ,subCategoryServiceName: cartItem.serviceCategoryName,subCategoryServiceUID: cartItem.subCategoryServiceUID,
                        cost: cartItem.cost.toString(),) )));
                      },
                      child: Text(
                        'Check Out',
                        style: myTextStylefontsize12WhiteW300,
                      )),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget buildCheckOutButton() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.deepPurple),
  //               onPressed: () {},
  //               child: Text(
  //                 'Check Out',
  //                 style: myTextStylefontsize16white,
  //               )),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildTotalCostEstimated() {
  //   User? user = ref.watch(userProvider);
  //   double totalCost = user!.myCart?.fold<double>(
  //         0,
  //         (previousValue, cartItem) => previousValue + cartItem.cost,
  //       ) ??
  //       0;

  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Text(
  //                 'Total Cost:',
  //                 style: myTextStylefontsize16white,
  //               ),
  //               Text(
  //                 '₹${totalCost.toStringAsFixed(2)}',
  //                 style: myTextStylefontsize16white,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
