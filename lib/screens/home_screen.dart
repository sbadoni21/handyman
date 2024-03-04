import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/menu_screen.dart';
import 'package:handyman/screens/my_bookings_page.dart';
import 'package:handyman/screens/search_page.dart';
import 'package:handyman/screens/subcategory_page.dart';
import 'package:handyman/services/data/crousaldata_service.dart';
import 'package:handyman/services/data/service_category_data.dart';
import 'package:handyman/services/data/top_service_provider_data.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/bottom_sheet_list_component.dart';
import 'package:handyman/widgets/bottomnavbar_component.dart';
import 'package:handyman/widgets/categories_component.dart';
import 'package:handyman/widgets/coursestile_component.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:handyman/widgets/heading_component.dart';
import 'package:handyman/widgets/search_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final userProvider = Provider<User?>((ref) {
  return ref.watch(userStateNotifierProvider);
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late User? user;
  int currentIndex = 0;

  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    user = ref.read(userProvider);
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: const MenuScreen(),
      drawerEnableOpenDragGesture: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [_buildHome(context), MyBookings()],
      ),
    );
  }

  Widget _buildHome(context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          flexibleSpace: _buildSearchBar(),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: 10),
            _buildCategories(),
            const SizedBox(height: 10),
            _buildTopServiceProviders(),
          ]),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Search',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DefaultTextStyle(
                            style: myTextStylefontsize12Black,
                            child: AnimatedTextKit(
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              animatedTexts: [
                                RotateAnimatedText(
                                  'Home Cleaning',
                                ),
                                RotateAnimatedText('Power Washing'),
                                RotateAnimatedText('Bathroom Repairs'),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.search)
                    ]),
              ),
            )));
  }

  Widget _buildCategories() {
    final serviceCategory = ref.watch(serviceCategoriesServiceProvider);

    return Consumer(
      builder: (context, watch, child) {
        return serviceCategory.when(
          data: (categoryList) {
            return SizedBox(
              height: 400,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final category = categoryList[index];

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return _buildBottomSheetContent(category.services);
                        },
                      );
                    },
                    child: CategoryItem(
                      imgUrl: category.servicePhoto,
                      text: category.serviceModelName,
                    ),
                  );
                },
              ),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                'Error: $error',
                style: myTextStylefontsize12WhiteW300,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCarousel() {
    final carousalAsyncValue = ref.watch(carousalProvider);

    return Consumer(
      builder: (context, watch, child) {
        return carousalAsyncValue.when(
          data: (carousalList) {
            return CarouselSlider(
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal,
                ),
                height: 229.0,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              items: carousalList.map((carousal) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () async {
                        // Course? course = await DataService()
                        //     .fetchCarousalCourse(carousal);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CourseDetailPage(
                        //             courses: course!)));
                      },
                      child: Image.network(
                        carousal.bannerImage,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text('Error: $error'),
            );
          },
        );
      },
    );
  }

  Widget _buildTopServiceProviders() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const HeadingTitle(title: "Top Service Providers"),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, watch, child) {
              final serviceProviderAsyncValue =
                  ref.watch(ServiceProviderService);
              return serviceProviderAsyncValue.when(
                data: (serviceProviders) {
                  return SizedBox(
                    height: 350,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          for (final serviceProvider in serviceProviders)
                            Tiles(serviceProvider: serviceProvider),
                        ],
                      ),
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text('Error: $error'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent(List<Service> services) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCategoryPage(
                                  subCategoryServices:
                                      service.subCategoryServices,
                                )));
                  },
                  child: BottomSheetListComponent(
                    service: service,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
