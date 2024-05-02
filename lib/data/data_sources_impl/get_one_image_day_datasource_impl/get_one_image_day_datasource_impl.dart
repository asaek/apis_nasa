import 'package:dio/dio.dart';
import 'package:nasa_apis/data/models/image_day_model/image_day_model.dart';

import '../../../config/constants/environments.dart';
import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/errors/errors.dart';

class GetOneImageDayDataSourceImpl implements GetOneImageDayDataSource {
  @override
  Future<ImageDayEntitie> getOneImageDay() async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.nasa.gov/planetary/apod',
        queryParameters: {
          'api_key': Environment.nasaDbKey,
        },
      ),
    );

    try {
      final Response<dynamic> response = await dio.get('');

      if (response.statusCode == 200) {
        final ImageDayModel imageDayModel =
            ImageDayModel.fromJson(response.data);

        return ImageDayEntitie(
          title: imageDayModel.title,
          url: imageDayModel.url,
          error: null,
          date: imageDayModel.date,
          explanation: imageDayModel.explanation,
          hdurl: imageDayModel.hdurl,
          mediaType: imageDayModel.mediaType,
        );
      } else {
        return ImageDayEntitie(
          title: null,
          url: null,
          error: Errores.errorServidor,
          date: null,
          explanation: null,
          hdurl: null,
          mediaType: null,
        );
      }
    } catch (e) {
      return ImageDayEntitie(
        title: null,
        url: null,
        error: Errores.errorServidor,
        date: null,
        explanation: null,
        hdurl: null,
        mediaType: null,
      );
    }
  }
}
