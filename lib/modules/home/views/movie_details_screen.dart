import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_app_sheba_xyz/core/routes/app_routes.dart';
import 'package:movie_app_sheba_xyz/modules/home/controllers/home_controller.dart';

import '../../../core/utils/helpers.dart';

class MovieDetailsScreen extends GetView<HomeController> {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(HomeController());
    // FocusManager.instance.primaryFocus?.unfocus();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff131516),
        body: Obx(
          () => controller.isMovieDetailsLoading.value || controller.isSimilarMovieListLoading.value
              ? Center(child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.orange,
                size: 50,
              ),)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              Helpers().checkAndAddHttp(controller.movieDetailsModel?.backdropPath ?? 'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.movieDetailsModel?.originalTitle ??
                                  controller.movieDetailsModel?.originalName ??
                                  '',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.timer_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        controller.movieDetailsModel?.runtime != null
                                            ? '${controller.movieDetailsModel?.runtime ?? ''} minutes'
                                            : controller.movieDetailsModel?.episodeRunTime?.isEmpty == true
                                            ? '0'
                                            : 'Ep. Avg ${controller.movieDetailsModel?.episodeRunTime?[0] ?? 0} minutes',
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        controller.movieDetailsModel?.voteAverage
                                                ?.toStringAsFixed(1) ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.movieDetailsModel?.releaseDate
                                                  .toString() ==
                                              null
                                          ? 'Release Date'
                                          : 'Airing Date',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.movieDetailsModel?.releaseDate
                                                  ?.isNotEmpty ==
                                              true
                                          ? Helpers().formatDate(controller
                                                  .movieDetailsModel
                                                  ?.releaseDate ??
                                              '')
                                          : 'From ${Helpers().formatDate(controller.movieDetailsModel?.firstAirDate ?? '')} \nTo ${Helpers().formatDate(controller.movieDetailsModel?.lastAirDate ?? '')}',
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Status: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blue,
                                          ),
                                          child: Text(
                                            controller.movieDetailsModel
                                                    ?.status ??
                                                '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Genre',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          for (int genreIndex = 0;
                                              genreIndex <
                                                  controller.movieDetailsModel!
                                                      .genres!.length;
                                              genreIndex++)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 0.15,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Text(
                                                controller
                                                        .movieDetailsModel
                                                        ?.genres?[genreIndex]
                                                        .name ??
                                                    '',
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildText(
                              controller.movieDetailsModel?.overview ?? '',
                            ),
                            (controller.exceedsMaxLines.value) == true
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          controller.isReadMore.value =
                                              !controller.isReadMore.value;
                                        },
                                        child: Text(
                                          (controller.isReadMore.value
                                              ? 'Read Less'
                                              : 'Read More..'),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 30,
                            ),
                            controller.similarMovieLists.isEmpty
                                ? const SizedBox()
                                : Text(
                              controller.movieDetailsModel?.originalTitle != null
                                  ? 'Related Movies'
                                  : 'Related Series',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                      ),
                      controller.similarMovieLists.isEmpty ? const SizedBox() :
                      Container(
                        height: 250,
                        margin: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Obx(
                          () => controller.isSimilarMovieListLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(child: CircularProgressIndicator(),),
                                )
                              : controller.similarMovieLists.isEmpty
                                ? const Padding(
                                  padding: EdgeInsets.only(top: 38.0),
                                  child: Text('Opps!!! No Data Found',),
                                )
                                : ListView.builder(
                                  itemCount: controller.similarMovieLists.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var similarItem = controller.similarMovieLists[index];
                                    return GestureDetector(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 160,
                                                width: 150,
                                                margin: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      Helpers().checkAndAddHttp(controller.similarMovieLists[index].backdropPath ?? 'https://t4.ftcdn.net/jpg/02/48/67/77/360_F_248677769_aH5CKcSQo5j5VEeovQpowoLxf7CmNZto.jpg'),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: 145,
                                            child: Text(
                                              controller.similarMovieLists[index]
                                                      .originalTitle ??
                                                  controller
                                                      .similarMovieLists[index]
                                                      .originalName ??
                                                  '',
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: (){
                                        if(controller.movieDetailsModel?.originalTitle == ""){
                                          controller.getTvDetails(similarItem.id ?? 0);
                                          // Get.to(() => const MovieDetailsScreen());
                                          Get.toNamed(AppRoutes.detailScreen,);
                                          controller.similarMovieLists.clear();
                                          controller.getSimilarMovieList(1, similarItem.id ?? 0, 'tv',);
                                        } else {
                                          controller.getMovieDetails(similarItem.id ?? 0);
                                          // Get.to(() => const MovieDetailsScreen());
                                          Get.toNamed(AppRoutes.detailScreen,);
                                          controller.similarMovieLists.clear();
                                          controller.getSimilarMovieList(1, similarItem.id ?? 0, 'movie',);
                                        }
                                      },
                                    );
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }



  Widget buildText(String text,) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text,),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: Get.width * 0.9);

    controller.exceedsMaxLines.value = textPainter.didExceedMaxLines;

    final lines = controller.isReadMore.value ? null : 3;
    return Text(
      text,
      maxLines: lines,
      overflow: controller.isReadMore.value
          ? TextOverflow.visible
          : TextOverflow.ellipsis,
    );
  }
}
