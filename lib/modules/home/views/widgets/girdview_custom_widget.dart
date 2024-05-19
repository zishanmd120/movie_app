import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/helpers.dart';
import '../../controllers/home_controller.dart';

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
