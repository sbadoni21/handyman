import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/services/data/service_provider.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/coursestile_component.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:handyman/widgets/subcategory_long_tile.dart';

class SubCategoryServiceDetailsPage extends ConsumerStatefulWidget {
  final SubCategoryService subCategoryService;

  const SubCategoryServiceDetailsPage({required this.subCategoryService});

  @override
  _SubCategoryServiceDetailsPageState createState() =>
      _SubCategoryServiceDetailsPageState();
}

class _SubCategoryServiceDetailsPageState
    extends ConsumerState<SubCategoryServiceDetailsPage> {
  late AutoDisposeFutureProvider<List<ServiceProvider>> serviceProviderProvider;

  @override
  void initState() {
    super.initState();
    serviceProviderProvider = AutoDisposeFutureProvider<List<ServiceProvider>>(
      (ref) async {
        final repository = ref.read(serviceProviderRepositoryProvider);
        return repository.getServiceProvidersForSubServiceCategory(
            widget.subCategoryService.subCategoryServiceUID);
      },
    );
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
          SizedBox(height: 10),
          Container(
            height: 130,
            width: double.infinity,
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
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
          _buildTopServiceProviders(),
        ],
      ),
    );
  }

  Widget _buildTopServiceProviders() {
    final serviceProvidersAsyncValue = ref.watch(serviceProviderProvider);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Service Providers",
                  style: myTextStylefontsize16Black,
                ),
              ],
            ),
            if (serviceProvidersAsyncValue != null &&
                serviceProvidersAsyncValue is AsyncData)

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceProvidersAsyncValue.value!.length,
                itemBuilder: (context, index) {
                  final serviceProvider =
                      serviceProvidersAsyncValue.value![index];
                  return Tiles(serviceProvider: serviceProvider);
                },
              ),
          ],
        ),
      ),
    );
  }
}
