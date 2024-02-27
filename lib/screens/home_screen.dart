import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/categories_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/menu_screen.dart';
import 'package:handyman/widgets/bottomnavbar_component.dart';
import 'package:handyman/widgets/categories_component.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:handyman/widgets/heading_component.dart';

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
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          _buildHome(context),
        ],
      ),
    );
  }

  Widget _buildHome(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildCategories(),
          const SizedBox(
            height: 10,
          )
          //  _buildTopServiceProviders() ,
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingTitle(title: "Categories"),
          const SizedBox(height: 16),
          SizedBox(
            height: 340,
            width: double.infinity,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categoriesData.length,
              itemBuilder: (context, index) {
                Category category = categoriesData[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         AllCoursesPage(selectedCategory: category),
                    //   ),
                    // );
                  },
                  child: CategoryItem(
                    imgUrl: category.image,
                    text: category.name,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildTopServiceProviders() {
  //   return Consumer(
  //             builder: (context, watch, child) {
  //               return carousalAsyncValue.when(
  //                 data: (carousalList) {
  //                   return CarouselSlider(
  //                     options: CarouselOptions(
  //                       scrollPhysics: const BouncingScrollPhysics(
  //                         decelerationRate: ScrollDecelerationRate.normal,
  //                       ),
  //                       height: 229.0,
  //                       viewportFraction: 1,
  //                       aspectRatio: 16 / 9,
  //                       enableInfiniteScroll: true,
  //                       autoPlay: true,
  //                       autoPlayInterval: const Duration(seconds: 3),
  //                       autoPlayAnimationDuration:
  //                           const Duration(milliseconds: 800),
  //                       autoPlayCurve: Curves.fastOutSlowIn,
  //                       enlargeCenterPage: true,
  //                       enlargeFactor: 0.3,
  //                       scrollDirection: Axis.horizontal,
  //                     ),
  //                     items: carousalList.map((carousal) {
  //                       return Builder(
  //                         builder: (BuildContext context) {
  //                           return GestureDetector(
  //                             onTap: () async {
  //                               Course? course = await DataService()
  //                                   .fetchCarousalCourse(carousal);
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) => CourseDetailPage(
  //                                           courses: course!)));
  //                             },
  //                             child: Image.network(
  //                               carousal.photo,
  //                               fit: BoxFit.fill,
  //                             ),
  //                           );
  //                         },
  //                       );
  //                     }).toList(),
  //                   );
  //                 },
  //                 loading: () {
  //                   return const Center(
  //                     child: CircularProgressIndicator(),
  //                   );
  //                 },
  //                 error: (error, stackTrace) {
  //                   return Center(
  //                     child: Text('Error: $error'),
  //                   );
  //                 },
  //               );
  //             },
  //           );
  // }
}
