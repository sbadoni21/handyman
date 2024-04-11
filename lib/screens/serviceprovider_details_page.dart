import 'package:flutter/material.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/screens/booknow_screen.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:ionicons/ionicons.dart';

class ServiceProviderDetailsPage extends StatefulWidget {
  final ServiceProvider serviceProvider;

  const ServiceProviderDetailsPage({Key? key, required this.serviceProvider})
      : super(key: key);

  @override
  _ServiceProviderDetailsPageState createState() =>
      _ServiceProviderDetailsPageState();
}

class _ServiceProviderDetailsPageState
    extends State<ServiceProviderDetailsPage> {
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
              ),
            ),
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
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Services",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.serviceProvider.services!.map((service) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.serviceModelName,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: service.subServiceCategories!.map((subService) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookNowScreen(
                                 
                                  serviceProviderUID:
                                      widget.serviceProvider.uid,
                                  serviceCategoryName:
                                      service.serviceName ?? '',
                                  serviceCategoryUID: service.serviceUID ?? '',
                                  serviceProviderName:
                                      widget.serviceProvider.name,
                                  subCategoryServiceName:
                                      subService.subCategoryServiceName,
                                  subCategoryServiceUID:
                                      subService.subCategoryServiceUID,
                                  cost: subService.rate,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  subService.subCategoryServiceName,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                Text(
                                  'Rate: ${subService.rate}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesCategories() {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
