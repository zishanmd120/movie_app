import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:movie_app_sheba_xyz/data/models/search_model.dart';
import 'package:movie_app_sheba_xyz/modules/home/controllers/home_controller.dart';
import 'package:movie_app_sheba_xyz/modules/home/views/movie_details_screen.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:overlay_search/overlay_search.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff131516),
        body: DefaultTabController(
          length: controller.tabBarLength,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Find Movies. Tv series, \nand more..',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: controller.searchTextEditingController,
                          onTap: (){
                            print('object');
                          },
                          onChanged: (value){
                            controller.searchedText.value = value;
                            controller.getSearchList(value);
                            if(value.isEmpty){
                              print('object');
                              controller.isSearching.value == false;
                            } else {
                              print('object1');
                              controller.isSearching.value == true;
                            }
                          },
                          style: const TextStyle(color: Colors.white,),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Sherlock Holmes",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            suffixIcon: Obx(() => controller.searchedText.value == '' ? const SizedBox() : GestureDetector(
                              child: Icon(
                                Icons.close,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              onTap: (){
                                controller.searchTextEditingController.clear();
                                controller.searchedText.value = '';
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TabBar(
                      controller: controller.tabController,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.orange,
                      indicatorPadding: const EdgeInsets.only(
                        right: 15,
                      ),
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.white.withOpacity(0.8),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelPadding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                        bottom: 7,
                        top: 7,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Text('Movies'),
                        Text('Tv Series'),
                        Text('Upcoming'),
                        Text('Popular'),
                        Text('On The Air'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        Expanded(
                          child: Obx(
                            () => controller.isMovieListLoading.value
                                ? const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Expanded(
                                        child: GridView.custom(
                                          controller: controller.scrollController,
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverWovenGridDelegate.count(
                                            crossAxisCount: 2,
                                            pattern: [
                                              const WovenGridTile(
                                                // 4 / 7,
                                                3.7 / 6.7,
                                                crossAxisRatio: 0.95,
                                                alignment:
                                                    AlignmentDirectional.centerEnd,
                                              ),
                                              const WovenGridTile(
                                                // 3.6 / 7,
                                                3.5 / 6.7,
                                                crossAxisRatio: 0.85,
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                            ],
                                          ),
                                          childrenDelegate:
                                              SliverChildBuilderDelegate(
                                            childCount:
                                                controller.movieLists.length,
                                            (context, index) {
                                              var movieItem =
                                                  controller.movieLists[index];
                                              return GestureDetector(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                        'https://image.tmdb.org/t/p/w500${movieItem.posterPath ?? ' '}',
                                                        // height: 250,
                                                        // width: Get.width * 0.5,
                                                        // fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Text(
                                                      movieItem.title ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  controller.getMovieDetails(
                                                      movieItem.id ?? 0);
                                                  Get.to(() =>
                                                      const MovieDetailsScreen());
                                                  controller.similarMovieLists
                                                      .clear();
                                                  controller.getSimilarMovieList(
                                                    1,
                                                    movieItem.id ?? 0,
                                                    'movie',
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      controller.isMovieListMoreLoading.value
                                          ? const SizedBox()
                                          : const SizedBox(),
                                    ],
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => controller.isTvListLoading.value
                                ? const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Expanded(
                                        child: GridView.custom(
                                          controller: controller.scrollController,
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverWovenGridDelegate.count(
                                            crossAxisCount: 2,
                                            pattern: [
                                              const WovenGridTile(
                                                3.7 / 6.7,
                                                crossAxisRatio: 0.95,
                                                alignment:
                                                    AlignmentDirectional.centerEnd,
                                              ),
                                              const WovenGridTile(
                                                3.5 / 6.7,
                                                crossAxisRatio: 0.85,
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                            ],
                                          ),
                                          childrenDelegate:
                                              SliverChildBuilderDelegate(
                                            childCount: controller
                                                .tvListModel?.movieLists?.length,
                                            (context, index) {
                                              var movieItem = controller
                                                  .tvListModel?.movieLists?[index];
                                              return GestureDetector(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                        'https://image.tmdb.org/t/p/w500${movieItem?.posterPath ?? ' '}',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Text(
                                                      movieItem?.originalName ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  controller.getTvDetails(
                                                      movieItem?.id ?? 0);
                                                  Get.to(() =>
                                                      const MovieDetailsScreen());
                                                  controller.similarMovieLists
                                                      .clear();
                                                  controller.getSimilarMovieList(
                                                    1,
                                                    movieItem?.id ?? 0,
                                                    'tv',
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      controller.isMovieListMoreLoading.value
                                          ? const SizedBox()
                                          : const SizedBox(),
                                    ],
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => controller.isUpcomingMovieListLoading.value
                                ? const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Expanded(
                                        child: GridView.custom(
                                          controller: controller.scrollController,
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverWovenGridDelegate.count(
                                            crossAxisCount: 2,
                                            pattern: [
                                              const WovenGridTile(
                                                3.7 / 6.7,
                                                crossAxisRatio: 0.95,
                                                alignment:
                                                    AlignmentDirectional.centerEnd,
                                              ),
                                              const WovenGridTile(
                                                3.5 / 6.7,
                                                crossAxisRatio: 0.85,
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                            ],
                                          ),
                                          childrenDelegate:
                                              SliverChildBuilderDelegate(
                                            childCount: controller
                                                .upcomingMovieLists.length,
                                            (context, index) {
                                              var movieItem = controller
                                                  .upcomingMovieLists[index];
                                              return GestureDetector(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                        'https://image.tmdb.org/t/p/w500${movieItem.posterPath ?? ' '}',
                                                        // height: 250,
                                                        // width: Get.width * 0.5,
                                                        // fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Text(
                                                      movieItem.originalTitle ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  controller.getMovieDetails(
                                                      movieItem.id ?? 0);
                                                  Get.to(() =>
                                                      const MovieDetailsScreen());
                                                  controller.similarMovieLists
                                                      .clear();
                                                  controller.getSimilarMovieList(
                                                    1,
                                                    movieItem.id ?? 0,
                                                    'movie',
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      controller.isMovieListMoreLoading.value
                                          ? const SizedBox()
                                          : const SizedBox(),
                                    ],
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => controller.isPopularMovieListLoading.value
                                ? const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Expanded(
                                        child: GridView.custom(
                                          controller: controller.scrollController,
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverWovenGridDelegate.count(
                                            crossAxisCount: 2,
                                            pattern: [
                                              const WovenGridTile(
                                                3.7 / 6.7,
                                                crossAxisRatio: 0.95,
                                                alignment:
                                                    AlignmentDirectional.centerEnd,
                                              ),
                                              const WovenGridTile(
                                                3.5 / 6.7,
                                                crossAxisRatio: 0.85,
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                            ],
                                          ),
                                          childrenDelegate:
                                              SliverChildBuilderDelegate(
                                            childCount:
                                                controller.popularMovieLists.length,
                                            (context, index) {
                                              var movieItem = controller
                                                  .popularMovieLists[index];
                                              return GestureDetector(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                        'https://image.tmdb.org/t/p/w500${movieItem.posterPath ?? ' '}',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Text(
                                                      movieItem.originalTitle ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  controller.getMovieDetails(
                                                      movieItem.id ?? 0);
                                                  Get.to(() =>
                                                      const MovieDetailsScreen());
                                                  controller.similarMovieLists
                                                      .clear();
                                                  controller.getSimilarMovieList(
                                                    1,
                                                    movieItem.id ?? 0,
                                                    'movie',
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      controller.isMovieListMoreLoading.value
                                          ? const SizedBox()
                                          : const SizedBox(),
                                    ],
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => controller.isOnTheAirTvListLoading.value
                                ? const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Expanded(
                                        child: GridView.custom(
                                          controller: controller.scrollController,
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverWovenGridDelegate.count(
                                            crossAxisCount: 2,
                                            pattern: [
                                              const WovenGridTile(
                                                3.7 / 6.7,
                                                crossAxisRatio: 0.95,
                                                alignment:
                                                    AlignmentDirectional.centerEnd,
                                              ),
                                              const WovenGridTile(
                                                3.5 / 6.7,
                                                crossAxisRatio: 0.85,
                                                alignment:
                                                    AlignmentDirectional.center,
                                              ),
                                            ],
                                          ),
                                          childrenDelegate:
                                              SliverChildBuilderDelegate(
                                            childCount:
                                                controller.onTheAirTvLists.length,
                                            (context, index) {
                                              var movieItem =
                                                  controller.onTheAirTvLists[index];
                                              return GestureDetector(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                        'https://image.tmdb.org/t/p/w500${movieItem.posterPath ?? ' '}',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Text(
                                                      movieItem.originalName ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  controller.getTvDetails(
                                                      movieItem.id ?? 0);
                                                  Get.to(() =>
                                                      const MovieDetailsScreen());
                                                  controller.similarMovieLists
                                                      .clear();
                                                  controller.getSimilarMovieList(
                                                    1,
                                                    movieItem.id ?? 0,
                                                    'tv',
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      controller.isMovieListMoreLoading.value
                                          ? const SizedBox()
                                          : const SizedBox(),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.searchedText.value == ''
                    ? const SizedBox()
                    : Positioned(
                        top: 170,
                        left: 20,
                        right: 20,
                        bottom: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.searchedData.value?.results?.length,
                            itemBuilder: (context, index) {
                              var item = controller
                                  .searchedData.value?.results?[index];
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    width: Get.width * 0.15,
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${item?.posterPath ?? ' '}',
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: SizedBox(
                                    width: Get.width * 0.6,
                                    child: Text(item?.title ?? '', style: const TextStyle(color: Colors.black,),)),
                                onTap: () {
                                  if (item?.mediaType == 'tv') {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    controller.getTvDetails(item?.id ?? 0);
                                    Get.to(() => const MovieDetailsScreen());
                                    controller.similarMovieLists.clear();
                                    controller.getSimilarMovieList(
                                      1,
                                      item?.id ?? 0,
                                      'tv',
                                    );
                                  } else if (item?.mediaType == 'movie') {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    controller
                                        .getMovieDetails(item?.id ?? 0);
                                    Get.to(() => const MovieDetailsScreen());
                                    controller.similarMovieLists.clear();
                                    controller.getSimilarMovieList(
                                      1,
                                      item?.id ?? 0,
                                      'movie',
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//list
//https://api.themoviedb.org/3/discover/movie?limit=10
//https://api.themoviedb.org/3/discover/tv?limit=10
//details
//https://api.themoviedb.org/3/movie/119450
//https://api.themoviedb.org/3/tv/2734
//
//https://api.themoviedb.org/3/genre/tv/list
//https://api.themoviedb.org/3/genre/movie/list
//https://api.themoviedb.org/3/movie/{movie_id}/similar
//https://api.themoviedb.org/3/movie/upcoming
//https://api.themoviedb.org/3/movie/popular
//https://api.themoviedb.org/3/tv/on_the_air
///
// : MasonryGridView.builder(
//     physics: const BouncingScrollPhysics(),
//     gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//     ),
//     itemCount: controller.movieListModel?.results?.length,
//     itemBuilder: (context, index){
//       var movieItem = controller.movieListModel?.results?[index];
//       return GestureDetector(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network('https://image.tmdb.org/t/p/w500${movieItem?.posterPath ?? ' '}',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Text(
//               movieItem?.originalTitle ?? '',
//             ),
//           ],
//         ),
//         onTap: () {
//           controller.getMovieDetails(movieItem?.id ?? 0);
//           Get.to(() => const MovieDetailsScreen());
//         },
//       );
//     },
//   ),
///
// final matchedItem = controller
//     .searchedData.value?.results
//     ?.firstWhere(
//   (e) => e.id.toString() == item.id,
//   orElse: () => SearchResults(),
// );
// if (matchedItem != null) {
//   if (matchedItem.mediaType == 'tv') {
//     controller.getTvDetails(matchedItem.id ?? 0);
//     Get.to(() => const MovieDetailsScreen());
//     controller.similarMovieLists.clear();
//     controller.getSimilarMovieList(
//         1, matchedItem.id ?? 0, 'tv');
//   } else if (matchedItem.mediaType == 'movie') {
//     controller.getMovieDetails(matchedItem.id ?? 0);
//     Get.to(() => const MovieDetailsScreen());
//     controller.similarMovieLists.clear();
//     controller.getSimilarMovieList(
//         1, matchedItem.id ?? 0, 'movie');
//   }
// }
///
// Obx(
//   () => GFSearchBar(
//     controller: controller.searchTextEditingController,
//     padding: EdgeInsets.zero,
//     searchList: controller.searchedData.value?.results ?? [],
//     searchQueryBuilder: (query, list) {
//       final debouncer = Debouncer(
//         delay: const Duration(
//           milliseconds: 500,
//         ),
//       );
//       debouncer.call(() => controller.getSearchList(query));
//       if ((controller.searchedData.value?.results?.length ?? 0) > 0) {
//         return controller.searchedData.value!.results!
//             .where((item) => (item.title ?? '')
//                 .toLowerCase()
//                 .contains(query.toLowerCase()))
//             .toList();
//       } else {
//         return [];
//       }
//     },
//     overlaySearchListItemBuilder: (item) {
//       final searchResult = item as SearchResults;
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6.0,),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(5.0),
//               child: searchResult.posterPath == null
//                   ? Image.network('https://www.clipartmax.com/png/middle/8-88403_size-movie-icon.png',
//                 height: 50,
//                 width: 60,
//                 fit: BoxFit.cover,
//               )
//                   : Image.network('https://image.tmdb.org/t/p/w500${searchResult.posterPath ?? ''}',
//                 height: 50,
//                 width: 60,
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 10,),
//               width: Get.width * 0.6,
//               child: Text(searchResult.title ?? '',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//     searchBoxInputDecoration: InputDecoration(
//       contentPadding: EdgeInsets.zero,
//       hintText: 'Sherlock Holmes',
//       hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
//       prefixIcon: Icon(Icons.search),
//       fillColor: Colors.blueGrey.withOpacity(0.15),
//       filled: true,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         borderSide: BorderSide(color: Colors.transparent),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         borderSide: BorderSide(color: Colors.transparent),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         borderSide: BorderSide(color: Colors.transparent),
//       ),
//     ),
//     noItemsFoundWidget: const Text('Empty'),
//     onItemSelected: (value) {
//       // Get.i;
//       // controller.overlayKey.;
//
//       // controller.searchTextEditingController.dispose();
//       controller.searchTextEditingController.clear();
//       FocusManager.instance.primaryFocus!.unfocus();
//       // FocusScope.of(context).unfocus();
//       print(value.id);
//       if(value.mediaType == 'tv'){
//         FocusManager.instance.primaryFocus?.unfocus();
//         controller.getTvDetails(value.id ?? 0);
//         Get.to(() => const MovieDetailsScreen());
//         controller.similarMovieLists.clear();
//         controller.getSimilarMovieList(1, value.id ?? 0, 'tv',);
//       } else if(value.mediaType == 'movie'){
//         FocusManager.instance.primaryFocus?.unfocus();
//         controller.getMovieDetails(value.id ?? 0);
//         Get.to(() => const MovieDetailsScreen());
//         controller.similarMovieLists.clear();
//         controller.getSimilarMovieList(1, value.id ?? 0, 'movie',);
//       }
//       // Navigator.of(controller.overlayKey.currentContext!).pop();
//       // if (controller.overlayKey.currentContext != null) {
//       //   Navigator.of(controller.overlayKey.currentContext!).pop();
//       // } else {
//       //   print("Overlay context is null");
//       // }
//       // widget.suffixAction?.call(controller.text.trim());
//       // controller.clear();
//       // FocusScope.of(context).unfocus();
//     },
//   ),
// ),
///
// TextFormField(
//   controller: controller.searchTextEditingController,
//   onTap: (){
//     print('object');
//   },
//   onChanged: (value){
//     controller.getSearchList(value);
//     if(value.isEmpty){
//       print('object');
//       controller.isSearching.value == false;
//     } else {
//       print('object1');
//       controller.isSearching.value == true;
//     }
//   },
//   style: const TextStyle(color: Colors.white,),
//   decoration: InputDecoration(
//     contentPadding: EdgeInsets.zero,
//     hintText: "Sherlock Holmes",
//     hintStyle: TextStyle(
//       color: Colors.white.withOpacity(0.3),
//     ),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30.0),
//       borderSide: const BorderSide(
//         color: Colors.white,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30.0),
//       borderSide: const BorderSide(
//         color: Colors.white,
//       ),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30.0),
//       borderSide: const BorderSide(
//         color: Colors.white,
//       ),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30.0),
//       borderSide: const BorderSide(
//         color: Colors.white,
//       ),
//     ),
//     prefixIcon: Icon(
//       Icons.search,
//       color: Colors.white.withOpacity(0.3),
//     ),
//   ),
// ),
///
// Obx(
//   (){
//     return SearchWithList(
//       overlaySearchController: controller.overlayController,
//       list: (controller.searchedData.value?.results ?? [])
//           .map(
//             (e) => OverlayItemModel(
//           title: e.title ?? "",
//           content: e.mediaType,
//           id: '${e.id}',
//         ),
//       )
//           .toList(),
//       contentStyle: const TextStyle(
//         color: Colors.white,
//       ),
//       titleStyle: const TextStyle(color: Colors.white,),
//       isLoading: controller.isSearchListLoading.value,
//       // hintStyle: Theme.of(context).textTheme.bodyMedium,
//       hintStyle: TextStyle(color: Colors.grey),
//       searchTextStyle: TextStyle(color: Colors.white),
//       overlayBackgroundColor: Colors.black,
//       hint: "Search Stock",
//       notFoundTextStyle: const TextStyle(color: Colors.white),
//       searchBackgroundColor: Colors.blueGrey.withOpacity(0.5),
//       overlayWidth: Get.width,
//       shiftOverlayFromLeft: -20,
//       suffixAction: () {
//         controller.overlayController.hideOverlay();
//         controller.overlayController.clearSearchQuery();
//         controller.searchTextEditingController.clear();
//       },
//       notFoundText: "Stock Not Found",
//       onItemSelected: (item) {
//         if (item.content == 'tv') {
//           FocusManager.instance.primaryFocus?.unfocus();
//           controller.getTvDetails(int.parse(item.id ?? ''));
//           Get.to(() => const MovieDetailsScreen());
//           controller.similarMovieLists.clear();
//           controller.getSimilarMovieList(
//             1,
//             int.parse(item.id ?? ''),
//             'tv',
//           );
//         } else if (item.content == 'movie') {
//           FocusManager.instance.primaryFocus?.unfocus();
//           controller
//               .getMovieDetails(int.parse(item.id ?? ''));
//           Get.to(() => const MovieDetailsScreen());
//           controller.similarMovieLists.clear();
//           controller.getSimilarMovieList(
//             1,
//             int.parse(item.id ?? ''),
//             'movie',
//           );
//         }
//       },
//       onChanged: (value) {
//         print(value);
//         controller.getSearchList(value);
//       },
//       onTap: () {
//
//       },
//     );
//   },
// ),


