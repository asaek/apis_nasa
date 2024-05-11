import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apis/data/mappers/ImageDayEntitie_to_ImageDayModel_mapper.dart';
import 'package:nasa_apis/data/models/models.dart';

void main() {
  group("Testing Mapper", () {
    test("Testing mapperImageDayEntitieToImageDayModel convercion Correcta",
        () {
      //? Arrange -> Nos preparamos para ejecutar el text
      final imageDayModel = ImageDayModel(
        title: "title",
        url: "url",
        date: DateTime(2021, 10, 10),
        explanation: "explanation",
        hdurl: "hdurl",
        mediaType: "mediaType",
        copyright: null,
        serviceVersion: "serviceVersion",
      );
      //? Act -> Eejeutamos el test
      final result =
          mapperImageDayEntitieToImageDayModel(imageDayModel: imageDayModel);
      //? Assert -> Verificamos que el resultado sea el esperado
      expect(result.title, imageDayModel.title);
      expect(result.url, imageDayModel.url);
      expect(result.date, imageDayModel.date);
      expect(result.explanation, imageDayModel.explanation);
      expect(result.hdurl, imageDayModel.hdurl);
      expect(result.mediaType, imageDayModel.mediaType);
    });

    test("Testing mapperImageDayEntitieToImageDayModel convercion incorrecta",
        () {
      //? Arrange -> Nos preparamos para ejecutar el text
      final ImageDayModel imageDayModel = ImageDayModel(
        title: "title",
        url: "url",
        date: DateTime(2021, 10, 10),
        explanation: "explanation",
        hdurl: "hdurl",
        mediaType: "mediaType",
        copyright: null,
        serviceVersion: "serviceVersion",
      );

      //? Act -> Eejeutamos el test
      final result =
          mapperImageDayEntitieToImageDayModel(imageDayModel: imageDayModel);

      //? Assert -> Verificamos que el resultado sea el esperado
      expect(result.title, isNot(imageDayModel.title));
      expect(result.url, imageDayModel.url);
      expect(result.date, imageDayModel.date);
      expect(result.explanation, imageDayModel.explanation);
      expect(result.hdurl, imageDayModel.hdurl);
      expect(result.mediaType, imageDayModel.mediaType);
    });
  });
}
