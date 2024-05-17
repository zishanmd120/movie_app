import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_details_model.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_list_model.dart';
import 'package:movie_app_sheba_xyz/data/repositories/movie_provider.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  RxBool isReadMore = false.obs;

  TextEditingController searchTextEditingController = TextEditingController();

  TabController ? tabController;
  int tabBarLength = 5;

  ScrollController scrollController = ScrollController();
  int moviePageNumber = 1;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: tabBarLength, vsync: this);
    scrollController.addListener(scrollMovie);
    getMovieList();
    getTvList();
  }

  RxBool isMovieListLoading = false.obs;
  MovieListModel ? movieListModel;
  List<MovieList> movieLists = [];
  Future<void> getMovieList() async {
    isMovieListLoading.value = true;
    var response = await MovieProvider().getMovieList(moviePageNumber);
    if(response != null){
      // movieListModel = response;
      // movieLists = response.movieLists ?? [];
      movieListModel = response;
      movieLists.addAll(movieListModel?.movieLists ?? []);
      isMovieListLoading.value = false;
    } else {
      isMovieListLoading.value = false;
    }
  }

  scrollMovie(){
    if((movieListModel?.totalPages ?? 0) > moviePageNumber){
      if(scrollController.position.pixels >= (scrollController.position.maxScrollExtent / 2)){
        moviePageNumber++;
        getMovieListMore(moviePageNumber);
      }
    }
  }

  RxBool isMovieListMoreLoading = false.obs;
  Future<void> getMovieListMore(int pageNumber) async {
    isMovieListMoreLoading.value = true;
    var response = await MovieProvider().getMovieList(pageNumber);
    if(response != null){
      movieListModel = response;
      movieLists.addAll(movieListModel?.movieLists ?? []);
      isMovieListMoreLoading.value = false;
    } else {
      isMovieListMoreLoading.value = false;
    }
  }

  RxBool isTvListLoading = false.obs;
  MovieListModel ? tvListModel;
  Future<void> getTvList() async {
    isTvListLoading.value = true;
    var response = await MovieProvider().getTvList();
    if(response != null){
      tvListModel = response;
      isTvListLoading.value = false;
    } else {
      isTvListLoading.value = false;
    }
  }

  RxBool isMovieDetailsLoading = false.obs;
  MovieDetailsModel ? movieDetailsModel;
  Future<void> getMovieDetails(int id) async {
    isMovieDetailsLoading.value = true;
    var response = await MovieProvider().getMovieDetails(id);
    if(response != null){
      movieDetailsModel = response;
      isMovieDetailsLoading.value = false;
    } else {
      isMovieDetailsLoading.value = false;
    }
  }
  Future<void> getTvDetails(int id) async {
    isMovieDetailsLoading.value = true;
    var response = await MovieProvider().getTvDetails(id);
    if(response != null){
      movieDetailsModel = response;
      isMovieDetailsLoading.value = false;
    } else {
      isMovieDetailsLoading.value = false;
    }
  }


  List<MovieList> similarMovieLists = [];
  RxBool isSimilarMovieListLoading = false.obs;
  Future<void> getSimilarMovieList(int id, int moviePageNumber) async {
    isSimilarMovieListLoading.value = true;
    var response = await MovieProvider().getSimilarMovieList(moviePageNumber, id);
    if(response != null){
      // movieListModel = response;
      // movieLists = response.movieLists ?? [];
      movieListModel = response;
      similarMovieLists.addAll(movieListModel?.movieLists ?? []);
      isSimilarMovieListLoading.value = false;
    } else {
      isSimilarMovieListLoading.value = false;
    }
  }


  formatDate(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

}