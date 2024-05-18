import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_app_sheba_xyz/core/routes/app_routes.dart';
import 'package:movie_app_sheba_xyz/core/utils/helpers.dart';
import 'package:movie_app_sheba_xyz/modules/home/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xff131516),
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
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.searchTextEditingController,
                          onTap: () {
                            print('object');
                          },
                          onChanged: (value) {
                            controller.searchedText.value = value;
                            controller.getSearchList(value);
                            if (value.isEmpty) {
                              print('object');
                              controller.isSearching.value == false;
                            } else {
                              print('object1');
                              controller.isSearching.value == true;
                            }
                          },
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
                            suffixIcon: Obx(
                              () => controller.searchedText.value == ''
                                  ? const SizedBox()
                                  : GestureDetector(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      onTap: () {
                                        controller.searchTextEditingController
                                            .clear();
                                        controller.searchedText.value = '';
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    ),
                            ),
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
                        Obx(
                          () => controller.isMovieListLoading.value
                              ? Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: LoadingAnimationWidget.dotsTriangle(
                                      color: Colors.orange,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Expanded(
                                      child: GridView.custom(
                                        controller:
                                            controller.scrollControllerMovies,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverWovenGridDelegate.count(
                                          crossAxisCount: 2,
                                          pattern: [
                                            const WovenGridTile(
                                              // 4 / 7,
                                              3.7 / 6.7,
                                              crossAxisRatio: 0.95,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
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
                                                      Helpers().checkAndAddHttp(movieItem.posterPath ?? 'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
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
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.getMovieDetails(
                                                    movieItem.id ?? 0);
                                                Get.toNamed(
                                                  AppRoutes.detailScreen,
                                                );
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
                        Obx(
                          () => controller.isTvListLoading.value
                              ? Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: LoadingAnimationWidget.dotsTriangle(
                                      color: Colors.orange,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Expanded(
                                      child: GridView.custom(
                                        controller:
                                            controller.scrollControllerTvSeries,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverWovenGridDelegate.count(
                                          crossAxisCount: 2,
                                          pattern: [
                                            const WovenGridTile(
                                              3.7 / 6.7,
                                              crossAxisRatio: 0.95,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
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
                                          childCount: controller.tvLists.length,
                                          (context, index) {
                                            var movieItem =
                                                controller.tvLists[index];
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
                                                      Helpers().checkAndAddHttp(movieItem.posterPath ?? 'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Text(
                                                    movieItem.originalName ??
                                                        '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.getTvDetails(
                                                    movieItem.id ?? 0);
                                                Get.toNamed(
                                                  AppRoutes.detailScreen,
                                                );
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
                                    controller.isTvListMoreLoading.value
                                        ? const SizedBox()
                                        : const SizedBox(),
                                  ],
                                ),
                        ),
                        Obx(
                          () => controller.isUpcomingMovieListLoading.value
                              ? Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: LoadingAnimationWidget.dotsTriangle(
                                      color: Colors.orange,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Expanded(
                                      child: GridView.custom(
                                        controller:
                                            controller.scrollControllerUpcoming,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverWovenGridDelegate.count(
                                          crossAxisCount: 2,
                                          pattern: [
                                            const WovenGridTile(
                                              3.7 / 6.7,
                                              crossAxisRatio: 0.95,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
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
                                                      Helpers().checkAndAddHttp(movieItem.posterPath ?? 'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Text(
                                                    movieItem.originalTitle ??
                                                        '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.getMovieDetails(
                                                    movieItem.id ?? 0);
                                                Get.toNamed(
                                                  AppRoutes.detailScreen,
                                                );
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
                                    controller.isUpcomingMovieListMoreLoading
                                            .value
                                        ? const SizedBox()
                                        : const SizedBox(),
                                  ],
                                ),
                        ),
                        Obx(
                          () => controller.isPopularMovieListLoading.value
                              ? Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: LoadingAnimationWidget.dotsTriangle(
                                      color: Colors.orange,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Expanded(
                                      child: GridView.custom(
                                        controller:
                                            controller.scrollControllerPopular,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverWovenGridDelegate.count(
                                          crossAxisCount: 2,
                                          pattern: [
                                            const WovenGridTile(
                                              3.7 / 6.7,
                                              crossAxisRatio: 0.95,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
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
                                              .popularMovieLists.length,
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
                                                      Helpers().checkAndAddHttp(movieItem.posterPath ?? 'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Text(
                                                    movieItem.originalTitle ??
                                                        '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.getMovieDetails(
                                                    movieItem.id ?? 0);
                                                Get.toNamed(
                                                  AppRoutes.detailScreen,
                                                );
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
                                    controller
                                            .isPopularMovieListMoreLoading.value
                                        ? const SizedBox()
                                        : const SizedBox(),
                                  ],
                                ),
                        ),
                        Obx(
                          () => controller.isOnTheAirTvListLoading.value
                              ? Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: LoadingAnimationWidget.dotsTriangle(
                                      color: Colors.orange,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Expanded(
                                      child: GridView.custom(
                                        controller:
                                            controller.scrollControllerOnTheAir,
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverWovenGridDelegate.count(
                                          crossAxisCount: 2,
                                          pattern: [
                                            const WovenGridTile(
                                              3.7 / 6.7,
                                              crossAxisRatio: 0.95,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
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
                                            var movieItem = controller
                                                .onTheAirTvLists[index];
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
                                                      Helpers().checkAndAddHttp(movieItem.posterPath ?? 'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Text(
                                                    movieItem.originalName ??
                                                        '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                controller.getTvDetails(
                                                    movieItem.id ?? 0);
                                                Get.toNamed(
                                                  AppRoutes.detailScreen,
                                                );
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
                                    controller.isOnTheAirTvListMoreLoading.value
                                        ? const SizedBox()
                                        : const SizedBox(),
                                  ],
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
                          constraints: const BoxConstraints(
                            minHeight: 200.0,
                            maxHeight: 500.0,
                          ),
                          child: Obx(
                            () => controller.checkForNull.value == true
                                ? const Center(
                                    child: Text(
                                      'No Data Found',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .searchedData.value?.results?.length,
                                    itemBuilder: (context, index) {
                                      var item = controller
                                          .searchedData.value?.results?[index];
                                      return ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: SizedBox(
                                            width: Get.width * 0.15,
                                            child: Image.network(
                                              Helpers().checkAndAddHttp(item?.posterPath ?? 'https://e7.pngegg.com/pngimages/130/1021/png-clipart-movie-logo-movie-logo-film-tape.png'),
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        title: SizedBox(
                                            width: Get.width * 0.6,
                                            child: Text(
                                              item?.title ?? item?.name ?? '',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                        onTap: () {
                                          if (item?.mediaType == 'tv') {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            controller
                                                .getTvDetails(item?.id ?? 0);
                                            Get.toNamed(
                                              AppRoutes.detailScreen,
                                            );
                                            controller.similarMovieLists
                                                .clear();
                                            controller.getSimilarMovieList(
                                              1,
                                              item?.id ?? 0,
                                              'tv',
                                            );
                                          } else if (item?.mediaType ==
                                              'movie') {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            controller
                                                .getMovieDetails(item?.id ?? 0);
                                            Get.toNamed(
                                              AppRoutes.detailScreen,
                                            );
                                            controller.similarMovieLists
                                                .clear();
                                            controller.getSimilarMovieList(
                                              1,
                                              item?.id ?? 0,
                                              'movie',
                                            );
                                          }
                                          controller.searchTextEditingController
                                              .clear();
                                          controller.searchedText.value = '';
                                        },
                                      );
                                    },
                                  ),
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
