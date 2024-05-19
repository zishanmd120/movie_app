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
                        Obx(() => GridviewCustomWidget(
                          isLoading: controller.isMovieListLoading.value,
                          isMoreLoading: controller.isMovieListMoreLoading.value,
                          controller: controller,
                          scrollController: controller.scrollControllerMovies,
                          watchItemList: controller.movieLists,
                          detailsType: 'movie',
                        ),),
                        Obx(() => GridviewCustomWidget(
                          isLoading: controller.isTvListLoading.value,
                          isMoreLoading: controller.isTvListMoreLoading.value,
                          controller: controller,
                          scrollController: controller.scrollControllerTvSeries,
                          watchItemList: controller.tvLists,
                          detailsType: 'tv',
                        ),),
                        Obx(() => GridviewCustomWidget(
                          isLoading: controller.isUpcomingMovieListLoading.value,
                          isMoreLoading: controller.isUpcomingMovieListMoreLoading.value,
                          controller: controller,
                          scrollController: controller.scrollControllerUpcoming,
                          watchItemList: controller.upcomingMovieLists,
                          detailsType: 'movie',
                        ),),
                        Obx(() => GridviewCustomWidget(
                          isLoading: controller.isPopularMovieListLoading.value,
                          isMoreLoading: controller.isPopularMovieListMoreLoading.value,
                          controller: controller,
                          scrollController: controller.scrollControllerPopular,
                          watchItemList: controller.popularMovieLists,
                          detailsType: 'movie',
                        ),),
                        Obx(() => GridviewCustomWidget(
                          isLoading: controller.isOnTheAirTvListLoading.value,
                          isMoreLoading: controller.isOnTheAirTvListMoreLoading.value,
                          controller: controller,
                          scrollController: controller.scrollControllerOnTheAir,
                          watchItemList: controller.onTheAirTvLists,
                          detailsType: 'tv',
                        ),),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          constraints: const BoxConstraints(
                            maxHeight: 230.0,
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
                                    itemCount: controller.searchedData.value?.results?.length,
                                    itemBuilder: (context, index) {
                                      var item = controller.searchedData.value?.results?[index];
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

class GridviewCustomWidget extends StatelessWidget {
  const GridviewCustomWidget({
    super.key,
    required this.isLoading,
    required this.isMoreLoading,
    required this.controller,
    required this.scrollController,
    required this.watchItemList,
    required this.detailsType,
  });

  final bool isLoading;
  final bool isMoreLoading;
  final HomeController controller;
  final ScrollController scrollController;
  final List watchItemList;
  final String detailsType;

  @override
  Widget build(BuildContext context) {
    return isLoading
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
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverWovenGridDelegate.count(
                    crossAxisCount: 2,
                    pattern: [
                      const WovenGridTile(
                        3.7 / 6.7,
                        crossAxisRatio: 0.95,
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                      const WovenGridTile(
                        3.5 / 6.7,
                        crossAxisRatio: 0.85,
                        alignment: AlignmentDirectional.center,
                      ),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: watchItemList.length,
                    (context, index) {
                      var movieItem = watchItemList[index];
                      return GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                              child: Image.network(
                                Helpers().checkAndAddHttp(movieItem
                                        .posterPath ??
                                    'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              movieItem.originalName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (detailsType == 'movie') {
                            controller.getMovieDetails(movieItem.id ?? 0);
                            Get.toNamed(
                              AppRoutes.detailScreen,
                            );
                            controller.similarMovieLists.clear();
                            controller.getSimilarMovieList(
                              1,
                              movieItem.id ?? 0,
                              'movie',
                            );
                          } else if (detailsType == 'tv') {
                            controller.getTvDetails(movieItem.id ?? 0);
                            Get.toNamed(
                              AppRoutes.detailScreen,
                            );
                            controller.similarMovieLists.clear();
                            controller.getSimilarMovieList(
                              1,
                              movieItem.id ?? 0,
                              'tv',
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              isMoreLoading ? const SizedBox() : const SizedBox(),
            ],
          );
  }
}


