import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_app_sheba_xyz/modules/home/controllers/home_controller.dart';
import 'package:movie_app_sheba_xyz/modules/home/views/movie_details_screen.dart';

class HomeScreen extends GetView<HomeController>{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff131516),
        body: DefaultTabController(
          length: controller.tabBarLength,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Find Movies. Tv series, \nand more..',
                      style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500,),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: controller.searchTextEditingController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: "Sherlock Holmes",
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white,),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white,),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white,),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white,),
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.3),),
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
                  indicatorPadding: const EdgeInsets.only(right: 15,),
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.white.withOpacity(0.8),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: const EdgeInsets.only(left: 20, right: 10, bottom: 7, top: 7,),
                  labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500,),
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
                    Column(
                      children: [
                        Expanded(
                          child: Obx(
                            () => controller.isMovieListLoading.value
                                ? const Center(child: SizedBox(height: 30, width: 30,child: CircularProgressIndicator(),),)
                                : Column(
                                  children: [
                                    const SizedBox(height: 16,),
                                    Expanded(
                                      child: GridView.custom(
                                          controller: controller.scrollController,
                                          padding: EdgeInsets.zero,
                                          gridDelegate: SliverWovenGridDelegate.count(
                                            crossAxisCount: 2,
                                            pattern: [
                                              const WovenGridTile(
                                                // 4 / 7,
                                                3.7 / 6.7,
                                                crossAxisRatio: 0.95,
                                                alignment: AlignmentDirectional.centerEnd,
                                              ),
                                              const WovenGridTile(
                                                // 3.6 / 7,
                                                3.5 / 6.7,
                                                crossAxisRatio: 0.85,
                                                alignment: AlignmentDirectional.center,
                                              ),
                                            ],
                                          ),
                                          childrenDelegate: SliverChildBuilderDelegate(
                                            childCount: controller.movieLists.length,
                                            (context, index) {
                                              var movieItem = controller.movieLists[index];
                                              return GestureDetector(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(20.0),
                                                      child: Image.network('https://image.tmdb.org/t/p/w500${movieItem.posterPath ?? ' '}',
                                                        // height: 250,
                                                        // width: Get.width * 0.5,
                                                        // fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 9,),
                                                    Text(
                                                      movieItem.originalTitle ?? '',
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500,),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  controller.getMovieDetails(movieItem.id ?? 0);
                                                  Get.to(() => const MovieDetailsScreen());
                                                  controller.similarMovieLists.clear();
                                                  controller.getSimilarMovieList(1, movieItem.id ?? 0,);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                    ),
                                    const SizedBox(height: 16,),
                                    controller.isMovieListMoreLoading.value
                                        ? const SizedBox()
                                        : const SizedBox(),
                                  ],
                                ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 16,
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
                                : GridView.custom(
                                    padding: EdgeInsets.zero,
                                    gridDelegate: SliverWovenGridDelegate.count(
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
                                                    BorderRadius.circular(20.0),
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
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            controller.getTvDetails(movieItem?.id ?? 0,);
                                            Get.to(() => const MovieDetailsScreen(),);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.flight, size: 350),
                    const Icon(Icons.directions_transit, size: 350),
                    const Icon(Icons.rocket, size: 350),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// : StaggeredGrid.count(
//   crossAxisCount: 2,
//   mainAxisSpacing: 15,
//   crossAxisSpacing: 15,
//   children: controller.movieListModel?.results?.map((movieItem) {
//     return StaggeredGridTile.count(
//       crossAxisCellCount: 2,
//       mainAxisCellCount: 2,
//       child: GestureDetector(
//         onTap: () {
//           controller.getMovieDetails(movieItem.id ?? 0);
//           Get.to(() => const MovieDetailsScreen());
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 130,
//               // width: double.infinity,
//               width: Get.width * 0.45,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     'https://image.tmdb.org/t/p/w500${movieItem.posterPath ?? ''}',
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Text(
//               movieItem.originalTitle ?? '',
//             ),
//           ],
//         ),
//       ),
//     );
//   }).toList() ?? [],
// ),
///
// StaggeredGrid.count(
// crossAxisCount: 4,
// mainAxisSpacing: 4,
// crossAxisSpacing: 4,
// children: controller.movieListModel?.results?.map((movieItem) {
// // final isEvenIndex = (controller.movieListModel?.results?.indexOf(movieItem) ?? 0) % 2 == 0;
// // final height = isEvenIndex ? 180.0 : 130.0;
// final index = controller.movieListModel?.results?.indexOf(movieItem);
// double height = 130;
// if (index == 0 || index == 3) {
// height = 180;
// }
// int crossAxisCellCount = 2;
// int mainAxisCellCount = 2;
// if (index == 0 || index == 3) {
// int crossAxisCellCount = 3;
// int mainAxisCellCount = 3;
// }
// return StaggeredGridTile.count(
// crossAxisCellCount: 2,
// mainAxisCellCount: 2,
// child: GestureDetector(
// onTap: () {
// controller.getMovieDetails(movieItem.id ?? 0);
// Get.to(() => const MovieDetailsScreen());
// },
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// // height: isEvenIndex ? 180 : 130,
// // height: height,
// height: 100,
// width: Get.width * 0.47,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(
// 'https://image.tmdb.org/t/p/w500${movieItem.posterPath ?? ''}',
// ),
// fit: BoxFit.cover,
// ),
// ),
// ),
// Text(
// movieItem.originalTitle ?? '',
// ),
// ],
// ),
// ),
// );
// }).toList() ?? [],
// ),
///
//     : StaggeredGrid.count(
//   gridDelegate: SliverWovenGridDelegate.count(
//     crossAxisCount: 2,
//     mainAxisSpacing: 8,
//     crossAxisSpacing: 8,
//     pattern: [
//       const WovenGridTile(1),
//       const WovenGridTile(
//         6 / 7,
//         crossAxisRatio: 0.85,
//         alignment: AlignmentDirectional.center,
//       ),
//     ],
//   ),
//   childrenDelegate: SliverChildBuilderDelegate(
//     (context, index) {
//       var movieItem = controller.movieListModel?.results?[index];
//       return GestureDetector(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 140,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 image: DecorationImage(
//                   image: NetworkImage('https://image.tmdb.org/t/p/w500${movieItem?.posterPath ?? ' '}',),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Text(
//               movieItem?.originalTitle ?? '',
//               // textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//         onTap: () {
//           controller
//               .getMovieDetails(movieItem?.id ?? 0);
//           Get.to(() => const MovieDetailsScreen());
//         },
//       );
//     },
//   ),
// ),
///
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
//   GridView.builder(
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//     mainAxisSpacing: 15,
//     crossAxisSpacing: 15,
//   ),
//   itemCount: controller.movieListModel?.results?.length,
//   itemBuilder: (context, index){
//     var movieItem = controller.movieListModel?.results?[index];
//     return GestureDetector(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 130,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage('https://image.tmdb.org/t/p/w500${movieItem?.posterPath ?? ' '}'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Text(movieItem?.originalTitle ?? '',
//             // textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//       onTap: (){
//         controller.getMovieDetails(movieItem?.id ?? 0);
//         Get.to(()=>const MovieDetailsScreen());
//       },
//     );
//   },
// ),

