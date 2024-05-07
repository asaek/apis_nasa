import 'package:dio/dio.dart';
import 'package:nasa_apis/data/models/epic_image/epic_image_model.dart';
import 'package:nasa_apis/domain/entities/entities.dart';

import '../../../config/constants/environments.dart';
import '../../../domain/data_sources/data_sources.dart';

const endPoint = 'https://epic.gsfc.nasa.gov/api/natural/date/2015-11-20';

class GetEpicImageDataSourceImpl extends GetEpicImageDataSource {
  GetEpicImageDataSourceImpl();

  @override
  Future<List<EpicImageEntity>> getEpicImage({required DateTime dia}) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://epic.gsfc.nasa.gov/api/natural/date/',
        queryParameters: {
          'api_key': Environment.nasaDbKey,
        },
      ),
    );
    try {
      final String formattedDate =
          '${dia.year}-${dia.month.toString().padLeft(2, '0')}-${dia.day.toString().padLeft(2, '0')}';

      final Response<dynamic> response = await dio.get(formattedDate);
      print(response);

      if (response.statusCode == 200) {
        final List<EpicImageModel> epicImageModel = (response.data as List)
            .map((e) => EpicImageModel.fromJson(e))
            .toList();

        final List<EpicImageEntity> epicImageEntity =
            EpicImageModelToEpicImageEntity(epicImageModel);

        return epicImageEntity;
      } else {
        return [
          EpicImageEntity(
            date: null,
            imageURLComplete: null,
            identifier: null,
            error: 'Error en la petición',
          )
        ];
      }
    } catch (e) {
      return [
        EpicImageEntity(
          date: null,
          imageURLComplete: null,
          identifier: null,
          error: 'Error en procesar las cosas',
        )
      ];
    }
  }
}

// const URLimageCompleta =
//     'https://epic.gsfc.nasa.gov/archive/natural/2015/10/31/png/epic_1b_20151031074844.png';

List<EpicImageEntity> EpicImageModelToEpicImageEntity(
        List<EpicImageModel> epicImageModel) =>
    epicImageModel.map((e) {
      late String dia;
      late String mes;
      if (e.date.day < 10) {
        dia = '0${e.date.day}';
      } else {
        dia = '${e.date.day}';
      }

      if (e.date.month < 10) {
        mes = '0${e.date.month}';
      } else {
        mes = '${e.date.month}';
      }

      return EpicImageEntity(
        date: e.date,
        imageURLComplete:
            'https://epic.gsfc.nasa.gov/archive/natural/${e.date.year}/$mes/$dia/png/${e.image}.png',
        identifier: e.identifier,
        error: null,
      );
    }).toList();
