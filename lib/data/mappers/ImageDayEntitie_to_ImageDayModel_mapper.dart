import 'package:nasa_apis/domain/entities/entities.dart';

import '../models/models.dart';

ImageDayEntitie mapperImageDayEntitieToImageDayModel(
    {required ImageDayModel imageDayModel}) {
  return ImageDayEntitie(
    title: imageDayModel.title,
    url: imageDayModel.url,
    error: null,
    date: imageDayModel.date,
    explanation: imageDayModel.explanation,
    hdurl: imageDayModel.hdurl,
    mediaType: imageDayModel.mediaType,
  );
}
