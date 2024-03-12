import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/screens/booknow_screen.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class ServiceProviderDetailsPage extends ConsumerStatefulWidget {
  final ServiceProvider serviceProvider;

  const ServiceProviderDetailsPage({super.key, required this.serviceProvider});

  @override
  _ServiceProviderDetailsPageState createState() =>
      _ServiceProviderDetailsPageState();
}

class _ServiceProviderDetailsPageState
    extends ConsumerState<ServiceProviderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: ListView(
          children: [
            SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  widget.serviceProvider.photo,
                  fit: BoxFit.contain,
                )),
            const SizedBox(
              height: 10,
            ),
            _buildServices(),
            const SizedBox(
              height: 10,
            ),
            _buildServicesCategories()
          ],
        ),
      ),
    );
  }

  Widget _buildServices() {
    return Container(
      decoration: const BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Services",
                  style: myTextStylefontsize16white,
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.serviceProvider.serviceCategories.length,
              itemBuilder: (context, index) {
                final serviceCategory =
                    widget.serviceProvider.serviceCategories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        serviceCategory.serviceCategory,
                        style: myTextStylefontsize14WhiteW400,
                      ),
                      Text(
                        '₹ ${serviceCategory.serviceCharge}',
                        style: myTextStylefontsize14WhiteW400,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Ionicons.add_circle,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesCategories() {
    return Container(
      decoration: const BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Services Catered for You",
                  style: myTextStylefontsize16white,
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.serviceProvider.serviceSubCategories.length,
              itemBuilder: (context, index) {
                final serviceCategory =
                    widget.serviceProvider.serviceSubCategories[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => BookNowScreen(
                    //             serviceProvider: widget.serviceProvider,
                    //             serviceSubCategories: serviceCategory)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          serviceCategory.serviceSubCategoryName.toString(),
                          style: myTextStylefontsize14WhiteW400,
                        ),
                        Text(
                          '₹ ${serviceCategory.subServiceCategoryRate.toString()}',
                          style: myTextStylefontsize14WhiteW400,
                        ),
                        const Icon(
                          Ionicons.add_circle,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
