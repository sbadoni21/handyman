import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/menu_screen.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:ionicons/ionicons.dart';

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
  late PageController _pageController;
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    user = ref.read(userProvider);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: const MenuScreen(),
      drawerEnableOpenDragGesture: true,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Icon(Ionicons.home)
                : Icon(Ionicons.home_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(Ionicons.trophy)
                : Icon(Ionicons.trophy_outline),
            label: 'My Contests',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(Ionicons.gift)
                : Icon(Ionicons.gift_outline),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Icon(Ionicons.medal)
                : Icon(Ionicons.medal_outline),
            label: 'Winners',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
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
          _buildUpcomingContests(),
        ],
      ),
    );
  }

  Widget _buildUpcomingContests() {
    return Placeholder();
    //   Consumer(
    //     builder: (context, ref, child) {

    //       if (contestsData is AsyncData<List<Contest>>) {
    //         final upcomingContests = contestsData.value;

    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.all(16.0),
    //               child: Text(
    //                 'Upcoming Contests',
    //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             Column(
    //               children: upcomingContests.map((contest) {
    //                 return ContestCard(context: context, contest: contest);
    //               }).toList(),
    //             ),
    //           ],
    //         );
    //       } else if (contestsData is AsyncLoading) {
    //         return CircularProgressIndicator();
    //       } else if (contestsData is AsyncError) {
    //         return Text('Error loading contests: ${contestsData.error}');
    //       } else {
    //         return Text('Unexpected state: $contestsData');
    //       }
    //     },
    //   );
    // }
  }
}
