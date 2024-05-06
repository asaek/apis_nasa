import 'package:dio/dio.dart';
import 'package:nasa_apis/data/models/epic_image/epic_image_model.dart';
import 'package:nasa_apis/domain/entities/entities.dart';

import '../../../config/constants/environments.dart';
import '../../../domain/data_sources/data_sources.dart';

class GetEpicImageDataSourceImpl extends GetEpicImageDataSource {
  // final EpicImageRemoteDataSource remoteDataSource;

  GetEpicImageDataSourceImpl();

  @override
  Future<EpicImageEntity> getEpicImage() async {
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
        final EpicImageModel epicImageModel =
            EpicImageModel.fromJson(response.data);
        final EpicImageEntity epicImageEntity = EpicImageEntity(
          date: epicImageModel.date,
          imageURLComplete: epicImageModel.image,
          identifier: epicImageModel.identifier,
          error: null,
        );
        return epicImageEntity;
      } else {
        return EpicImageEntity(
          date: null,
          imageURLComplete: null,
          identifier: null,
          error: 'Error en la peticion',
        );
      }
    } catch (e) {
      return EpicImageEntity(
        date: null,
        imageURLComplete: null,
        identifier: null,
        error: 'Error en la peticion',
      );
    }
  }
}
