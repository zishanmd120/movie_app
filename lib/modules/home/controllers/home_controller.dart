import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_details_model.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_list_model.dart';
import 'package:movie_app_sheba_xyz/data/models/search_model.dart';
import 'package:movie_app_sheba_xyz/data/repositories/movie_provider.dart';
import 'package:overlay_search/overlay_search.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin{

  RxBool isReadMore = false.obs;

  TabController ? tabController;
  int tabBarLength = 5;

  ScrollController scrollController = ScrollController();
  int moviePageNumber = 1;

  RxBool exceedsMaxLines = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: tabBarLength, vsync: this);
    scrollController.addListener(scrollMovie);
    getMovieList();
    getTvList();
    getUpcomingMovieList();
    getPopularMovieList();
    getOnTheAirTvList();
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
  Future<void> getSimilarMovieList(int id, int moviePageNumber, String fetchType,) async {
    isSimilarMovieListLoading.value = true;
    var response = await MovieProvider().getSimilarMovieList(moviePageNumber, id, fetchType);
    if(response != null){
      // movieListModel = response;
      // movieLists = response.movieLists ?? [];
      movieListModel = response;
      similarMovieLists.addAll(movieListModel?.movieLists ?? []);
      print(similarMovieLists.length);
      isSimilarMovieListLoading.value = false;
    } else {
      isSimilarMovieListLoading.value = false;
    }
  }


  RxBool isUpcomingMovieListLoading = false.obs;
  List<MovieList> upcomingMovieLists = [];
  Future<void> getUpcomingMovieList() async {
    isUpcomingMovieListLoading.value = true;
    var response = await MovieProvider().getUpcomingMovieList(moviePageNumber);
    if(response != null){
      movieListModel = response;
      upcomingMovieLists.addAll(movieListModel?.movieLists ?? []);
      isUpcomingMovieListLoading.value = false;
    } else {
      isUpcomingMovieListLoading.value = false;
    }
  }

  RxBool isPopularMovieListLoading = false.obs;
  List<MovieList> popularMovieLists = [];
  Future<void> getPopularMovieList() async {
    isPopularMovieListLoading.value = true;
    var response = await MovieProvider().getPopularMovieList(moviePageNumber);
    if(response != null){
      movieListModel = response;
      popularMovieLists.addAll(movieListModel?.movieLists ?? []);
      isPopularMovieListLoading.value = false;
    } else {
      isPopularMovieListLoading.value = false;
    }
  }

  RxBool isOnTheAirTvListLoading = false.obs;
  List<MovieList> onTheAirTvLists = [];
  Future<void> getOnTheAirTvList() async {
    isOnTheAirTvListLoading.value = true;
    var response = await MovieProvider().getOnTheAirTvList(moviePageNumber);
    if(response != null){
      movieListModel = response;
      onTheAirTvLists.addAll(movieListModel?.movieLists ?? []);
      isOnTheAirTvListLoading.value = false;
    } else {
      isOnTheAirTvListLoading.value = false;
    }
  }

  formatDate(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }


  RxString searchedText = ''.obs;
  final OverlaySearchController overlayController = OverlaySearchController();
  final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
  // var searchTextEditingController = TextEditingController().obs;
  var searchTextEditingController = TextEditingController();
  RxBool isSearchListLoading = false.obs;
  RxBool isSearching = false.obs;
  // SearchModel ? searchedData;
  // Rx<SearchModel?> searchedData = Rx<SearchModel?>();
  final Rx<SearchModel?> searchedData = Rx<SearchModel?>(null);

  Future<void> getSearchList(String value) async {
    isSearchListLoading.value = true;
    var response = await MovieProvider().getSearchList(value);
    if(response != null){
      searchedData.value = response;
      isSearchListLoading.value = false;
    } else {
      isSearchListLoading.value = false;
    }
  }

}