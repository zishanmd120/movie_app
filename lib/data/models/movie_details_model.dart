class MovieDetailsModel {
  String? backdropPath;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? firstAirDate;
  String? lastAirDate;
  int? runtime;
  String? status;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  List<int>? episodeRunTime;

  MovieDetailsModel({
        this.backdropPath,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originCountry,
        this.originalLanguage,
        this.originalTitle,
        this.originalName,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.firstAirDate,
        this.lastAirDate,
        this.runtime,
        this.status,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.episodeRunTime,
      });

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    firstAirDate = json['first_air_date'];
    lastAirDate = json['last_air_date'];
    runtime = json['runtime'];
    status = json['status'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    episodeRunTime = (json['episode_run_time'] as List<dynamic>?)?.cast<int>() ?? [];
  }

}


class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}


