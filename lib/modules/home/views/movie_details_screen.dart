import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_sheba_xyz/modules/home/controllers/home_controller.dart';

class MovieDetailsScreen extends GetView<HomeController> {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff131516),
        body: Obx(() => controller.isMovieDetailsLoading.value ? const CircularProgressIndicator() : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500${controller.movieDetailsModel?.backdropPath ?? ''}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text(controller.movieDetailsModel?.originalTitle ?? controller.movieDetailsModel?.originalName ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, color: Colors.white, size: 20,),
                            const SizedBox(width: 7,),
                            Text('${controller.movieDetailsModel?.runtime ?? ' '}',
                              style: const TextStyle(color: Colors.white, fontSize: 15,),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 20,),
                            const SizedBox(width: 7,),
                            Text(controller.movieDetailsModel?.voteAverage?.toStringAsFixed(1) ?? '',
                              style: const TextStyle(color: Colors.white, fontSize: 15,),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Divider(color: Colors.grey.withOpacity(0.5),),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.movieDetailsModel?.releaseDate.toString() == null
                                ? 'Release Date' : 'Airing Date',
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
                            ),
                            const SizedBox(height: 10,),
                            Text(controller.movieDetailsModel?.releaseDate?.isNotEmpty == true
                                ? controller.formatDate(controller.movieDetailsModel?.releaseDate ?? '')
                                : 'From ${controller.formatDate(controller.movieDetailsModel?.firstAirDate ?? '')} \nTo ${controller.formatDate(controller.movieDetailsModel?.lastAirDate ?? '')}',
                              style: const TextStyle(color: Colors.white,),
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                const Text('Status: ', style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                ),),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5,),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Text(controller.movieDetailsModel?.status ?? '', style: const TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Genre',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: 150,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  for(int genreIndex = 0; genreIndex < controller.movieDetailsModel!.genres!.length; genreIndex++)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2,),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        border: Border.all(color: Colors.white, width: 0.15,),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Text(controller.movieDetailsModel?.genres?[genreIndex].name ?? '',
                                        style: const TextStyle(color: Colors.white, ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Divider(color: Colors.grey.withOpacity(0.7),),
                    const SizedBox(height: 10,),
                    buildText(controller.movieDetailsModel?.overview ?? '',),
                    (controller.movieDetailsModel?.overview?.length ?? 0) > 200
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
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500,),
                              ),
                            ),
                          ],
                        )
                        : const SizedBox(),
                    const SizedBox(height: 20,),
                    const Text('Related Movies',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ),
              Container(
                height: 250,
                margin: const EdgeInsets.only(left: 20,),
                child: Obx(() => controller.isSimilarMovieListLoading.value ? CircularProgressIndicator() : ListView.builder(
                  itemCount: controller.similarMovieLists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          width: 150,
                          margin: const EdgeInsets.only(right: 15,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: NetworkImage('https://image.tmdb.org/t/p/w500${controller.similarMovieLists[index].backdropPath ?? ''}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        SizedBox(
                          width: 145,
                          child: Text(controller.similarMovieLists[index].originalTitle ?? controller.similarMovieLists[index].originalName ?? '',
                            style: const TextStyle(color: Colors.white,),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),),
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),),
      ),
    );
  }

  Widget buildText(String text){
    final lines = controller.isReadMore.value ? null : 3;
    return Text(
      text,
      maxLines: lines,
      overflow: controller.isReadMore.value ? TextOverflow.visible: TextOverflow.ellipsis,
      style: const TextStyle(color: Colors.white,),
    );
  }
}