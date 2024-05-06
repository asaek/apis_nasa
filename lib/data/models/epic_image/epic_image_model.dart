import 'dart:convert';

class EpicImageModel {
  final String identifier;
  final String caption;
  final String image;
  final String version;
  final DateTime date;

  EpicImageModel({
    required this.identifier,
    required this.caption,
    required this.image,
    required this.version,
    required this.date,
  });

  factory EpicImageModel.fromRawJson(String str) =>
      EpicImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EpicImageModel.fromJson(Map<String, dynamic> json) => EpicImageModel(
        identifier: json["identifier"],
        caption: json["caption"],
        image: json["image"],
        version: json["version"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "caption": caption,
        "image": image,
        "version": version,
        "date": date.toIso8601String(),
      };
}
