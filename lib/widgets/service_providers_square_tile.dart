import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServicePorviderSquareTile extends ConsumerStatefulWidget {
  final ServiceProvider serviceProvider;

  ServicePorviderSquareTile({
    Key? key,
    required this.serviceProvider,
  }) : super(key: key);

  @override
  _ServicePorviderSquareTileState createState() =>
      _ServicePorviderSquareTileState();
}

class _ServicePorviderSquareTileState
    extends ConsumerState<ServicePorviderSquareTile> {
  Future<double>? distanceFuture;

  @override
  void initState() {
    User? user = ref.read(userStateNotifierProvider);
    super.initState();
    distanceFuture = calculateDistance(
      user!.latitude.toDouble(),
      user.longitude.toDouble(),
      widget.serviceProvider.latitude.toDouble(),
      widget.serviceProvider.longitude.toDouble(),
    );
  }

  Future<double> calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    try {
      double distance = await Geolocator.distanceBetween(
        startLat,
        startLng,
        endLat,
        endLng,
      );
      return distance / 1000000;
    } catch (e) {
      print("Error calculating distance: $e");
      return 0.0; // Handle errors gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: widget.serviceProvider.photo.isNotEmpty
                      ? NetworkImage(widget.serviceProvider.photo)
                      : AssetImage('assets/images/placeholder_image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 4,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.serviceProvider.rating,
                  style: myTextStylefontsize14BlackW400,
                ),
              ),
            ),
          ],
        ),
        Text(
          widget.serviceProvider.name,
          style: myTextStylefontsize12Black,
        ),
        FutureBuilder<double>(
          future: distanceFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              double distance = snapshot.data ?? 0.0;
              return Row(
                children: [
                  Text(
                    'Distance: ',
                    style: myTextStylefontsize10BGCOLOR,
                  ),
                  Text(
                    '${distance.round()} Km',
                    style: myTextStylefontsize10Grey,
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
