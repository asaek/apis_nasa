class SearchResultEntity {
  final String? center;
  final String? title;
  final String? nasaId;
  final DateTime? dateCreated;
  final List<String>? keywords;
  final String? description508;
  final String? urlImage;
  final String? error;

  SearchResultEntity({
    required this.center,
    required this.title,
    required this.nasaId,
    required this.dateCreated,
    required this.keywords,
    required this.description508,
    required this.urlImage,
    required this.error,
  });
}
