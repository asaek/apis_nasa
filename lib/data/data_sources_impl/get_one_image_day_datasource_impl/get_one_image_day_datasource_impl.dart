import 'package:dio/dio.dart';
import 'package:nasa_apis/data/models/image_day_model/image_day_model.dart';

import '../../../config/constants/environments.dart';
import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/errors/errors.dart';
import '../../mappers/ImageDayEntitie_to_ImageDayModel_mapper.dart';

class GetOneImageDayDataSourceImpl implements GetOneImageDayDataSource {
  @override
  Future<List<ImageDayEntitie>> getOneImageDay(
      {required int cantidadImages}) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.nasa.gov/planetary/apod',
        queryParameters: {
          'api_key': Environment.nasaDbKey,
          'count': cantidadImages,
        },
      ),
    );

    try {
      List<ImageDayEntitie> imagesDayEntitie = [];
      final Response<dynamic> response = await dio.get('');

      // print(response.data);

      if (response.statusCode == 200) {
        // print('Peticion correcta');
        final List<ImageDayModel> imagesDayModel = (response.data as List)
            .map((e) => ImageDayModel.fromJson(e))
            .toList();

        // print('Paso el primero mapeo');
        for (final ImageDayModel imageDayModel in imagesDayModel) {
          imagesDayEntitie.add(mapperImageDayEntitieToImageDayModel(
              imageDayModel: imageDayModel));
        }
        // print('Paso el segundo mapeo');

        return imagesDayEntitie;
      } else {
        return [
          ImageDayEntitie(
            title: null,
            url: null,
            error: Errores.errorServidor,
            date: null,
            explanation: null,
            hdurl: null,
            mediaType: null,
          ),
        ];
      }
    } catch (e) {
      return [
        ImageDayEntitie(
          title: null,
          url: null,
          error: '${Errores.errorServidor} error: ${e.toString()}',
          date: null,
          explanation: null,
          hdurl: null,
          mediaType: null,
        )
      ];
    }
  }
}
