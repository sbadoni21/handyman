import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/widgets/search_bar.dart';

final userProvider = Provider<User?>((ref) {
  return ref.watch(userStateNotifierProvider);
});

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchBarButtonState createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    User? user = ref.read(userProvider);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchBarsection(
                          onSearch: (query) async {
                            // List<Course> results = await SearchDataService()
                            //     .fetchAllCourses(searchQuery: query);
                            // List<Videos> searchVideo = await SearchDataService()
                            //     .searchVideo(query, user!);
                            setState(() {
                              // searchResults = results;
                              // searchLectures = searchVideo;
                            });
                          },
                        ),
                        const SizedBox(height: 26),

                        // if (searchResults.isNotEmpty)
                        //   SizedBox(
                        //     height: 170,
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: searchResults.length,
                        //       itemBuilder: (context, index) {
                        //         Course searchResult = searchResults[index];
                        //         return GestureDetector(
                        //           onTap: () async {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) =>
                        //                         CourseDetailPage(
                        //                             courses: searchResult)));
                        //           },
                        //           child: Padding(
                        //               padding: const EdgeInsets.only(
                        //                   left: 8.0, right: 8),
                        //               child: Tiles(
                        //                 course: searchResult,
                        //               )),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // const SizedBox(height: 26),
                        // const HeadingTitle(title: "Lectures"),
                        // const SizedBox(height: 16),
                        // if (searchLectures.isNotEmpty)
                        //   SizedBox(
                        //     height: 80,
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: searchLectures.length,
                        //       itemBuilder: (context, index) {
                        //         Videos searchResult = searchLectures[index];
                        //         return GestureDetector(
                        //             onTap: () async {
                        //               Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) =>
                        //                           VideoPlayerScreen(
                        //                               video: searchResult)));
                        //             },
                        //             child: Padding(
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 8),
                        //               child:
                        //                   VideoSearchTile(video: searchResult),
                        //             ));
                        //       },
                        //     ),
                        //   )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
