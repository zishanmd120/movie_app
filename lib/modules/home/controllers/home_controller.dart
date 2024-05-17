import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_details_model.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_list_model.dart';
import 'package:movie_app_sheba_xyz/data/models/search_model.dart';
import 'package:movie_app_sheba_xyz/data/repositories/movie_provider.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  RxBool isReadMore = false.obs;

  TabController ? tabController;
  int tabBarLength = 5;

  ScrollController scrollControllerMovies = ScrollController();
  ScrollController scrollControllerTvSeries = ScrollController();
  ScrollController scrollControllerUpcoming = ScrollController();
  ScrollController scrollControllerPopular = ScrollController();
  ScrollController scrollControllerOnTheAir = ScrollController();
  int moviePageNumber = 1;
  int upcomingMoviePageNumber = 1;
  int popularMoviePageNumber = 1;
  int tvSeriesPageNumber = 1;
  int onTheAirTvSeriesPageNumber = 1;

  RxBool exceedsMaxLines = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: tabBarLength, vsync: this);
    scrollControllerMovies.addListener(scrollMovie);
    scrollControllerTvSeries.addListener(scrollTvSeries);
    scrollControllerUpcoming.addListener(scrollUpcomingMovie);
    scrollControllerPopular.addListener(scrollPopularMovie);
    scrollControllerOnTheAir.addListener(scrollOnTheAirTvSeries);
    getMovieList();
    getTvList(tvSeriesPageNumber);
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
      if(scrollControllerMovies.position.pixels >= (scrollControllerMovies.position.maxScrollExtent / 2)){
        moviePageNumber++;
        getMovieListMore(moviePageNumber);
      }
    }
  }

  scrollTvSeries() async{
    if((tvListModel?.totalPages ?? 0) > tvSeriesPageNumber){
      if(scrollControllerTvSeries.position.pixels >= (scrollControllerTvSeries.position.maxScrollExtent / 2)){
        isTvListMoreLoading.value = true;
        tvSeriesPageNumber++;
        await getTvListMore(tvSeriesPageNumber);
        isTvListMoreLoading.value = false;
      }
    }
  }

  scrollPopularMovie(){
    if((popularMovieListModel?.totalPages ?? 0) > popularMoviePageNumber){
      if(scrollControllerPopular.position.pixels >= (scrollControllerPopular.position.maxScrollExtent / 2)){
        popularMoviePageNumber++;
        getPopularMovieMoreList();
      }
    }
  }

  scrollUpcomingMovie(){
    if((upcomingMovieListModel?.totalPages ?? 0) > upcomingMoviePageNumber){
      if(scrollControllerUpcoming.position.pixels >= (scrollControllerUpcoming.position.maxScrollExtent / 2)){
        upcomingMoviePageNumber++;
        getUpcomingMovieMoreList();
      }
    }
  }

  scrollOnTheAirTvSeries(){
    if((onTheAirTvSeriesListModel?.totalPages ?? 0) > onTheAirTvSeriesPageNumber){
      if(scrollControllerOnTheAir.position.pixels >= (scrollControllerOnTheAir.position.maxScrollExtent / 2)){
        onTheAirTvSeriesPageNumber++;
        getOnTheAirTvListMore();
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
  List<MovieList> tvLists = [];
  Future<void> getTvList(int pageNumber) async {
    isTvListLoading.value = true;
    var response = await MovieProvider().getTvList(pageNumber);
    if(response != null){
      tvListModel = response;
      tvLists.addAll(tvListModel?.movieLists ?? []);
      isTvListLoading.value = false;
    } else {
      isTvListLoading.value = false;
    }
  }

  RxBool isTvListMoreLoading = false.obs;
  Future<void> getTvListMore(int pageNumber) async {
    isTvListMoreLoading.value = true;
    var response = await MovieProvider().getTvList(pageNumber);
    if(response != null){
      tvListModel = response;
      tvLists.addAll(tvListModel?.movieLists ?? []);
      isTvListMoreLoading.value = false;
    } else {
      isTvListMoreLoading.value = false;
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
  UpcomingMovieListModel ? upcomingMovieListModel;
  List<MovieList> upcomingMovieLists = [];
  Future<void> getUpcomingMovieList() async {
    isUpcomingMovieListLoading.value = true;
    var response = await MovieProvider().getUpcomingMovieList(upcomingMoviePageNumber);
    if(response != null){
      upcomingMovieListModel = response;
      upcomingMovieLists.addAll(upcomingMovieListModel?.movieLists ?? []);
      isUpcomingMovieListLoading.value = false;
    } else {
      isUpcomingMovieListLoading.value = false;
    }
  }

  RxBool isUpcomingMovieListMoreLoading = false.obs;
  Future<void> getUpcomingMovieMoreList() async {
    isUpcomingMovieListMoreLoading.value = true;
    var response = await MovieProvider().getUpcomingMovieList(upcomingMoviePageNumber);
    if(response != null){
      upcomingMovieListModel = response;
      upcomingMovieLists.addAll(upcomingMovieListModel?.movieLists ?? []);
      isUpcomingMovieListMoreLoading.value = false;
    } else {
      isUpcomingMovieListMoreLoading.value = false;
    }
  }

  RxBool isPopularMovieListLoading = false.obs;
  PopularMovieListModel ? popularMovieListModel;
  List<MovieList> popularMovieLists = [];
  Future<void> getPopularMovieList() async {
    isPopularMovieListLoading.value = true;
    var response = await MovieProvider().getPopularMovieList(popularMoviePageNumber);
    if(response != null){
      popularMovieListModel = response;
      popularMovieLists.addAll(popularMovieListModel?.movieLists ?? []);
      isPopularMovieListLoading.value = false;
    } else {
      isPopularMovieListLoading.value = false;
    }
  }

  RxBool isPopularMovieListMoreLoading = false.obs;
  Future<void> getPopularMovieMoreList() async {
    isPopularMovieListMoreLoading.value = true;
    var response = await MovieProvider().getPopularMovieList(popularMoviePageNumber);
    if(response != null){
      popularMovieListModel = response;
      popularMovieLists.addAll(popularMovieListModel?.movieLists ?? []);
      isPopularMovieListMoreLoading.value = false;
    } else {
      isPopularMovieListMoreLoading.value = false;
    }
  }

  RxBool isOnTheAirTvListLoading = false.obs;
  OnTheAirTvSeriesListModel ? onTheAirTvSeriesListModel;
  List<MovieList> onTheAirTvLists = [];
  Future<void> getOnTheAirTvList() async {
    isOnTheAirTvListLoading.value = true;
    var response = await MovieProvider().getOnTheAirTvList(onTheAirTvSeriesPageNumber);
    if(response != null){
      onTheAirTvSeriesListModel = response;
      onTheAirTvLists.addAll(onTheAirTvSeriesListModel?.movieLists ?? []);
      isOnTheAirTvListLoading.value = false;
    } else {
      isOnTheAirTvListLoading.value = false;
    }
  }

  RxBool isOnTheAirTvListMoreLoading = false.obs;
  Future<void> getOnTheAirTvListMore() async {
    isOnTheAirTvListMoreLoading.value = true;
    var response = await MovieProvider().getOnTheAirTvList(onTheAirTvSeriesPageNumber);
    if(response != null){
      onTheAirTvSeriesListModel = response;
      onTheAirTvLists.addAll(onTheAirTvSeriesListModel?.movieLists ?? []);
      isOnTheAirTvListMoreLoading.value = false;
    } else {
      isOnTheAirTvListMoreLoading.value = false;
    }
  }

  formatDate(String date){
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }


  RxString searchedText = ''.obs;
  // var searchTextEditingController = TextEditingController().obs;
  var searchTextEditingController = TextEditingController();
  RxBool isSearchListLoading = false.obs;
  RxBool isSearching = false.obs;
  // SearchModel ? searchedData;
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