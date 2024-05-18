class MovieListModel {
  int? page;
  List<MovieList>? movieLists;
  int? totalPages;
  int? totalResults;

  MovieListModel({this.page, this.movieLists, this.totalPages, this.totalResults});

  MovieListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieLists = <MovieList>[];
      json['results'].forEach((v) {
        movieLists!.add(MovieList.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class UpcomingMovieListModel {
  int? page;
  List<MovieList>? movieLists;
  int? totalPages;
  int? totalResults;

  UpcomingMovieListModel({this.page, this.movieLists, this.totalPages, this.totalResults});

  UpcomingMovieListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieLists = <MovieList>[];
      json['results'].forEach((v) {
        movieLists!.add(MovieList.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class PopularMovieListModel {
  int? page;
  List<MovieList>? movieLists;
  int? totalPages;
  int? totalResults;

  PopularMovieListModel({this.page, this.movieLists, this.totalPages, this.totalResults});

  PopularMovieListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieLists = <MovieList>[];
      json['results'].forEach((v) {
        movieLists!.add(MovieList.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class OnTheAirTvSeriesListModel {
  int? page;
  List<MovieList>? movieLists;
  int? totalPages;
  int? totalResults;

  OnTheAirTvSeriesListModel({this.page, this.movieLists, this.totalPages, this.totalResults});

  OnTheAirTvSeriesListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieLists = <MovieList>[];
      json['results'].forEach((v) {
        movieLists!.add(MovieList.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class MovieList {
  String? backdropPath;
  int? id;
  String? originalTitle;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieList(
      {
        this.backdropPath,
        this.id,
        this.originalTitle,
        this.originalName,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  MovieList.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    originalTitle = json['original_title'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

}