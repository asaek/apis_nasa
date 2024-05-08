import 'dart:convert';

class SearchResultModel {
  final String href;
  final List<Datum> data;
  final List<Link> links;

  SearchResultModel({
    required this.href,
    required this.data,
    required this.links,
  });

  factory SearchResultModel.fromRawJson(String str) =>
      SearchResultModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        href: json["href"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //     "href": href,
  //     "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //     "links": List<dynamic>.from(links.map((x) => x.toJson())),
  // };
}

class Datum {
  final String center;
  final String title;
  final String photographer;
  final List<String> keywords;
  final String nasaId;
  final String mediaType;
  final DateTime dateCreated;
  final String description;

  Datum({
    required this.center,
    required this.title,
    required this.photographer,
    required this.keywords,
    required this.nasaId,
    required this.mediaType,
    required this.dateCreated,
    required this.description,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        center: json["center"],
        title: json["title"],
        photographer: json["photographer"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        nasaId: json["nasa_id"],
        mediaType: json["media_type"],
        dateCreated: DateTime.parse(json["date_created"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "center": center,
        "title": title,
        "photographer": photographer,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "nasa_id": nasaId,
        "media_type": mediaType,
        "date_created": dateCreated.toIso8601String(),
        "description": description,
      };
}

class Link {
  final String href;
  final String rel;
  final String render;

  Link({
    required this.href,
    required this.rel,
    required this.render,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        href: json["href"],
        rel: json["rel"],
        render: json["render"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "rel": rel,
        "render": render,
      };
}
