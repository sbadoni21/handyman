// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handyman/models/service_categories_model.dart';
// import 'package:handyman/models/service_provider_model.dart';
// import 'package:handyman/services/data/generalservice_provider.dart';
// import 'package:handyman/services/data/service_provider.dart';
// import 'package:handyman/utils/app_colors.dart';
// import 'package:handyman/widgets/coursestile_component.dart';
// import 'package:handyman/widgets/customappbar.dart';
// import 'package:handyman/widgets/service_providers_square_tile.dart';
// import 'package:handyman/widgets/subcategory_long_tile.dart';
// import 'package:lottie/lottie.dart';

// class SubCategoryServiceDetailsPage extends ConsumerStatefulWidget {
//   final SubCategoryService subCategoryService;

//   const SubCategoryServiceDetailsPage({required this.subCategoryService});

//   @override
//   _SubCategoryServiceDetailsPageState createState() =>
//       _SubCategoryServiceDetailsPageState();
// }

// class _SubCategoryServiceDetailsPageState
//     extends ConsumerState<SubCategoryServiceDetailsPage> {
//   late AutoDisposeFutureProvider<List<ServiceProvider>> serviceProviderProvider;
//   late FutureProvider<List<ServiceProvider>> generalServiceProvider;

//   @override
//   void initState() {
//     super.initState();
//     serviceProviderProvider = AutoDisposeFutureProvider<List<ServiceProvider>>(
//       (ref) async {
//         final repository = ref.read(serviceProviderRepositoryProvider);
//         return repository.getServiceProvidersForSubServiceCategory(
//             widget.subCategoryService.subCategoryServiceUID);
//       },
//     );

//     generalServiceProvider = FutureProvider<List<ServiceProvider>>((ref) async {
//       final repository = GeneralServiceProvider();
//       return repository.getServiceProvidersForServiceCategory(
//         widget.subCategoryService.serviceCategoryUID,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: CustomAppBar(),
//       body: ListView(
//         children: [
//           Image.network(
//             widget.subCategoryService.subCategoryServicePhoto,
//             width: double.infinity,
//             height: 300,
//             fit: BoxFit.contain,
//             alignment: Alignment.center,
//           ),
//           SizedBox(height: 20),
//           Container(
//             height: 130,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         widget.subCategoryService.subCategoryServiceName,
//                         style: myTextStylefontsize16Black,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Text(
//                         'No of Users: ',
//                         style: myTextStylefontsize14GreyW700,
//                       ),
//                       Text(
//                         widget.subCategoryService.noOfUsers.toString(),
//                         style: myTextStylefontsize14GreyW700,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Text(
//                         'Starting from : ',
//                         style: myTextStylefontsize14GreyW700,
//                       ),
//                       Text(
//                         '₹ 50 ',
//                         style: myTextStylefontsize14GreyW700,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//               padding: EdgeInsets.all(15),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20))),
//               child: Text(
//                 'Service Provider for ${widget.subCategoryService.subCategoryServiceName}',
//                 style: myTextStylefontsize16Black,
//               )),
//           _buildServiceProviders(),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//               padding: EdgeInsets.all(15),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20))),
//               child: Text(
//                 'Top Service Provider',
//                 style: myTextStylefontsize16Black,
//               )),
//           _buildTopServiceProviders(),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//               padding: EdgeInsets.all(15),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20))),
//               child: Text(
//                 'General Service Provider',
//                 style: myTextStylefontsize16Black,
//               )),
//           _buildGeneralServiceProviders()
//         ],
//       ),
//     );
//   }

//   Widget _buildTopServiceProviders() {
//     final serviceProvidersAsyncValue = ref.watch(serviceProviderProvider);
//     return Container(
//       height: 250,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20))),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: serviceProvidersAsyncValue.when(
//           loading: () => SizedBox(
//               height: 250,
//               width: 250,
//               child: Lottie.asset('assets/lottie/loading.json')),
//           error: (error, stack) => Text('Error: $error'),
//           data: (serviceProviders) {
//             return SizedBox(
//               height: 250,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 physics: AlwaysScrollableScrollPhysics(),
//                 itemCount: serviceProviders.length,
//                 itemBuilder: (context, index) {
//                   final serviceProvider = serviceProviders[index];
//                   return Tiles(serviceProvider: serviceProvider);
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceProviders() {
//     final serviceProvidersAsyncValue = ref.watch(serviceProviderProvider);
//     return Container(
//       height: 250,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20))),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: serviceProvidersAsyncValue.when(
//           loading: () => SizedBox(
//               height: 250,
//               width: 250,
//               child: Lottie.asset('assets/lottie/loading.json')),
//           error: (error, stack) => Text('Error: $error'),
//           data: (serviceProviders) {
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               physics: AlwaysScrollableScrollPhysics(),
//               itemCount: serviceProviders.length,
//               itemBuilder: (context, index) {
//                 final serviceProvider = serviceProviders[index];
//                 return ServicePorviderSquareTile(
//                     serviceProvider: serviceProvider);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildGeneralServiceProviders() {
//     final serviceProvidersAsyncValue = ref.watch(generalServiceProvider);
//     return Container(
//       height: 250,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20))),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: serviceProvidersAsyncValue.when(
//           loading: () => SizedBox(
//               height: 250,
//               width: 250,
//               child: Lottie.asset('assets/lottie/loading.json')),
//           error: (error, stack) => Text('Error: $error'),
//           data: (serviceProviders) {
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               physics: AlwaysScrollableScrollPhysics(),
//               itemCount: serviceProviders.length,
//               itemBuilder: (context, index) {
//                 final serviceProvider = serviceProviders[index];
//                 return ServicePorviderSquareTile(
//                     serviceProvider: serviceProvider);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
