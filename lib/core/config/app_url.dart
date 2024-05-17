class AppUrl{

  static const String baseUrl = 'https://api.themoviedb.org/';
  static const String apiVersion = '3/';

  static const String baseUrlWithApiVersion = baseUrl + apiVersion;

  static const String getMovieListUrl = "${baseUrlWithApiVersion}discover/movie?limit=10&page=";
  static const String getUpcomingMovieListUrl = "${baseUrlWithApiVersion}movie/upcoming?limit=10&page=";
  static const String getPopularMovieListUrl = "${baseUrlWithApiVersion}movie/popular?limit=10&page=";
  static const String getMovieDetailsUrl = "${baseUrlWithApiVersion}movie/";

  static const String getTvListUrl = "${baseUrlWithApiVersion}discover/tv?limit=10&page=";
  static const String getOnTheAirTvListUrl = "${baseUrlWithApiVersion}tv/on_the_air?limit=10&page=";
  static const String getTvDetailsUrl = "${baseUrlWithApiVersion}tv/";


  static String getSimilarMovieUrl(movieId, page, type) => "$baseUrlWithApiVersion$type/$movieId/similar?limit=10&page=$page";


  static const String getSearchUrl = "${baseUrlWithApiVersion}search/multi?limit=10&page=1&query=";

}