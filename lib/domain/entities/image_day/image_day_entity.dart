class ImageDayEntitie {
  final DateTime? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? title;
  final String? url;
  final String? error;

  ImageDayEntitie({
    required this.error,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.title,
    required this.url,
  });
}
