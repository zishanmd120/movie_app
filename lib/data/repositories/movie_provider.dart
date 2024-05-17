import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_details_model.dart';
import 'package:movie_app_sheba_xyz/data/models/movie_list_model.dart';
import 'package:movie_app_sheba_xyz/data/repositories/base_provider.dart';
import '../../core/config/app_url.dart';


class MovieProvider extends GetConnect{

  Future<MovieListModel?> getMovieList(int pageNumber) async {
    print('pageNumber $pageNumber');
    var response = await BaseProviders().getResponseWithAccessToken(url: '${AppUrl.getMovieListUrl}$pageNumber',);
    if (response != null) {
      print(response.body);
      final map = jsonDecode(response.body);
      return MovieListModel.fromJson(map);
    } else {
      return null;
    }
  }

  Future<MovieDetailsModel?> getMovieDetails(int id) async {
    var response = await BaseProviders().getResponseWithAccessToken(url: '${AppUrl.getMovieDetailsUrl}$id',);
    if (response != null) {
      print(response.body);
      final map = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(map);
    } else {
      return null;
    }
  }

  Future<MovieListModel?> getTvList() async {
    var response = await BaseProviders().getResponseWithAccessToken(url: AppUrl.getTvListUrl,);
    if (response != null) {
      print(response.body);
      final map = jsonDecode(response.body);
      return MovieListModel.fromJson(map);
    } else {
      return null;
    }
  }

  Future<MovieDetailsModel?> getTvDetails(int id) async {
    var response = await BaseProviders().getResponseWithAccessToken(url: '${AppUrl.getTvDetailsUrl}$id',);
    if (response != null) {
      print(response.body);
      final map = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(map);
    } else {
      return null;
    }
  }

  Future<MovieListModel?> getSimilarMovieList(int pageNumber, int movieId) async {
    print('pageNumber $pageNumber $movieId');
    var response = await BaseProviders().getResponseWithAccessToken(url: AppUrl.getSimilarMovieUrl(pageNumber, movieId),);
    if (response != null) {
      print(response.body);
      final map = jsonDecode(response.body);
      return MovieListModel.fromJson(map);
    } else {
      return null;
    }
  }

}