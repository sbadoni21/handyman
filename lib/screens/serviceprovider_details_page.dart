import 'package:flutter/material.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      appBar:const CustomAppBar(),
      body: Stack(
        children: [
      
        ],
      ),
    );
  }
}
