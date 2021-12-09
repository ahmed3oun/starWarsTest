// ignore_for_file: non_constant_identifier_names

class Movie {
  late String created;
  late String director;
  late String opening_crawl;
  late String title;
  late String release_date;
  late String url;

  Movie(
    this.created,
    this.director,
    this.opening_crawl,
    this.title,
    this.release_date,
    this.url,
  );

  factory Movie.fromJson(Map<String, dynamic> _json) {
    return Movie(_json['created'], _json['director'], _json['opening_crawl'],
        _json['title'], _json['release_date'], _json['url']);
  }

  String movieUrl() {
    //final AppConfig _appConfig = GetIt.instance.get<AppConfig>();

    return url;
  }
}
