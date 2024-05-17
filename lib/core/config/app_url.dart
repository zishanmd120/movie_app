class AppUrl{

  static const String baseUrl = 'https://api.themoviedb.org/';
  static const String apiVersion = '3/';

  static const String baseUrlWithApiVersion = baseUrl + apiVersion;

  static const String getMovieListUrl = "${baseUrlWithApiVersion}discover/movie?limit=10&page=";
  static const String getMovieDetailsUrl = "${baseUrlWithApiVersion}movie/";

  static const String getTvListUrl = "${baseUrlWithApiVersion}discover/tv?limit=10&page=";
  static const String getTvDetailsUrl = "${baseUrlWithApiVersion}tv/";


  static String getSimilarMovieUrl(movieId, page) => "${baseUrlWithApiVersion}movie/$movieId/similar?limit=10&page=$page";

}