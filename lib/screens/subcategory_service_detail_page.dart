import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/screens/booknow_screen.dart';
import 'package:handyman/services/data/service_provider.dart';

import 'package:handyman/utils/app_colors.dart';

import 'package:handyman/widgets/customappbar.dart';

import 'package:lottie/lottie.dart';

class SubCategoryServiceDetailsPage extends ConsumerStatefulWidget {
  final SubCategoryService subCategoryService;

  const SubCategoryServiceDetailsPage({required this.subCategoryService});

  @override
  _SubCategoryServiceDetailsPageState createState() =>
      _SubCategoryServiceDetailsPageState();
}

class _SubCategoryServiceDetailsPageState
    extends ConsumerState<SubCategoryServiceDetailsPage> {
  ServiceProviderRepository serviceProviderRepository =
      ServiceProviderRepository();

  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, dynamic>>> getServiceProvidersByCategory(
      SubCategoryService subCategoryService) async {
    try {
      List<Map<String, dynamic>> serviceProviders =
          await serviceProviderRepository
              .getServiceProviders(subCategoryService);
      return serviceProviders;
    } catch (e) {
      throw Exception("Error fetching service providers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Image.network(
            widget.subCategoryService.subCategoryServicePhoto,
            width: double.infinity,
            height: 300,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
          SizedBox(height: 20),
          Container(
            height: 130,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.subCategoryService.subCategoryServiceName,
                        style: myTextStylefontsize16Black,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'No of Users: ',
                        style: myTextStylefontsize14GreyW700,
                      ),
                      Text(
                        widget.subCategoryService.noOfUsers.toString(),
                        style: myTextStylefontsize14GreyW700,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Starting from : ',
                        style: myTextStylefontsize14GreyW700,
                      ),
                      Text(
                        '₹ 50 ',
                        style: myTextStylefontsize14GreyW700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text(
                'Service Provider for ${widget.subCategoryService.subCategoryServiceName}',
                style: myTextStylefontsize16Black,
              )),
          _buildServiceProviders(),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text(
                'Top Service Provider',
                style: myTextStylefontsize16Black,
              )),
          // _buildTopServiceProviders(),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text(
                'General Service Provider',
                style: myTextStylefontsize16Black,
              )),
          // _buildGeneralServiceProviders()
        ],
      ),
    );
  }

  Widget _buildServiceProviders() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getServiceProvidersByCategory(widget.subCategoryService),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No service providers found.');
            } else {
              List<Map<String, dynamic>> serviceProvidersData = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceProvidersData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> serviceProviderData =
                      serviceProvidersData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookNowScreen(
                                  serviceProviderUID: serviceProviderData['serviceProviderUID'],
                                  serviceCategoryName: serviceProviderData[
                                      'serviceCategoryName'],
                                  serviceCategoryUID:
                                      serviceProviderData['serviceCategoryUID'],
                                  serviceProviderName: serviceProviderData[
                                      'serviceProviderName'],
                                  subCategoryServiceName: serviceProviderData[
                                      'subCategoryServiceName'],
                                  subCategoryServiceUID: serviceProviderData[
                                      'subCategoryServiceUID'],
                                  cost: serviceProviderData['cost'])));
                    },
                    child: ListTile(
                      title: Text(serviceProviderData['serviceProviderName']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Category Name: ${serviceProviderData['serviceCategoryName']}',
                          ),
                          Text(
                            'Subcategory Service Name: ${serviceProviderData['subCategoryServiceName']}',
                          ),
                          Text(
                            'Cost: ${serviceProviderData['cost']}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Widget _buildTopServiceProviders() {
  //   final serviceProvidersAsyncValue = ref.watch(serviceProviderProvider);
  //   return Container(
  //     height: 250,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.only(
  //             bottomLeft: Radius.circular(20),
  //             bottomRight: Radius.circular(20))),
  //     child: Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: serviceProvidersAsyncValue.when(
  //         loading: () => SizedBox(
  //             height: 250,
  //             width: 250,
  //             child: Lottie.asset('assets/lottie/loading.json')),
  //         error: (error, stack) => Text('Error: $error'),
  //         data: (serviceProviders) {
  //           return SizedBox(
  //             height: 250,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               shrinkWrap: true,
  //               physics: AlwaysScrollableScrollPhysics(),
  //               itemCount: serviceProviders.length,
  //               itemBuilder: (context, index) {
  //                 final serviceProvider = serviceProviders[index];
  //                 return Tiles(serviceProvider: serviceProvider);
  //               },
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
