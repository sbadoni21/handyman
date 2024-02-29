import 'package:flutter/material.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/utils/app_colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                InfoPage(
                    "Best Solution for Every House Problems",
                    "We work to ensure people comfort at their home, and to provide the best and the fastest help at fair prices.",
                    "assets/images/infopic1.png",
                    false),
                InfoPage(
                    "Choose your Tasker by reviews, skills, and price",
                    "Chat, pay and review all through one platform",
                    "assets/images/infopic2.png",
                    false),
                InfoPage(
                    "Our Services",
                    "Plumbing Services, Painting Services, Renovation Services, Electrical Services Carpentry Services, Roofing Services",
                    "assets/images/infopic3.png",
                    false),
                InfoPage("Secure Payments", "Secure Payments",
                    "assets/images/infopic4.png", true),
              ],
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
                width: _currentPage == index ? 12 : 10,
                height: 10.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _currentPage == index ? Colors.white : Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  final String title;
  final String description;
  final String animation;
  final bool isLastScreen;

  InfoPage(this.title, this.description, this.animation, this.isLastScreen);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 400, width: screenWidth, child: Image.asset(animation)),
          Text(
            title,
            style: myTextStylefontsize24White,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: myTextStylefontsize14WhiteW400,
          ),
          SizedBox(
            height: 90,
          ),
          if (!isLastScreen)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Text('Skip')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    elevation: 5,
                  ),
                  onPressed: () {},
                  child: Container(
                      width: 100,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Swip Right ',
                          style: myTextStylefontsize12BGCOLOR,
                        ),
                      )),
                ),
              ],
            ),
          if (isLastScreen)
            Container(
              width: screenWidth,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Lets Go',
                        style: myTextStylefontsize16white,
                      ),
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
