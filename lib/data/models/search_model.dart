class SearchModel {
  int? page;
  List<SearchResults>? results;
  int? totalPages;
  int? totalResults;

  SearchModel({this.page, this.results, this.totalPages, this.totalResults});

  SearchModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <SearchResults>[];
      json['results'].forEach((v) {
        results!.add(SearchResults.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class SearchResults {
  String? backdropPath;
  int? id;
  String? originalTitle;
  String? posterPath;
  String? mediaType;
  String? title;
  String? originalName;
  String? name;

  SearchResults(
      {this.backdropPath,
        this.id,
        this.originalTitle,
        this.posterPath,
        this.mediaType,
        this.title,
        this.originalName,
        this.name,});

  SearchResults.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    title = json['title'];
    originalName = json['original_name'];
    name = json['name'];
  }

}

