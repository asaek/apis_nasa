import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apis/data/data_sources_impl/get_epic_image_datasource_impl/get_epic_image_datasource_impl.dart';
import 'package:nasa_apis/domain/entities/entities.dart';
import 'package:nasa_apis/presentation/bloc/service_locator.dart';

void main() {
  setUp(() async {
    // Asegúrate de que esta ruta apunta a tu archivo .env
    await dotenv.load(
      fileName: "assets/.env",
    );

    setupLocator();
  });
  group("Testing DataSource", () {
    test("Testing GetEpicImageDataSourceImpl", () async {
      //? Arrange -> Nos preparamos para ejecutar el test
      final DateTime dia = DateTime(2023, 10, 10);
      final getEpicImageDataSourceImpl =
          GetEpicImageDataSourceImpl(dio: locator<Dio>());

      //? Act -> Ejecutamos el test
      final resultFuture = getEpicImageDataSourceImpl.getEpicImage(dia: dia);

      //? Assert -> Verificamos que el resultado sea el esperado
      // Verifica que el Future complete
      expectLater(resultFuture, completes);

      final List<EpicImageEntity> result = await resultFuture;
      expect(result, isA<List<EpicImageEntity>>());

      // Verifica que la lista no esté vacía
      expect(result.isNotEmpty, true);
      if (result.isNotEmpty) {
        // Verifica algunas propiedades del primer elemento si la lista no está vacía
        expect(result.first.date, isNotNull);
        expect(result.first.imageURLComplete,
            contains('https://epic.gsfc.nasa.gov'));
        expect(result.first.error, isNull);
      }
    });
  });
}

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:nasa_apis/data/data_sources_impl/get_epic_image_datasource_impl/get_epic_image_datasource_impl.dart';
// import 'package:nasa_apis/domain/entities/entities.dart';

// class MockDio extends Mock implements Dio {}

// const endPoint = 'https://epic.gsfc.nasa.gov/api/natural/date/2021-01-01';

// void main() {
//   // final GetIt locator = GetIt.instance;
//   // late MockDio mockDio;
//   // late GetEpicImageDataSourceImpl dataSource;

//   // setUp(() {
//   //   locator.reset();
//   //   mockDio = MockDio();
//   //   setupLocator();

//   //   if (!locator.isRegistered<Dio>()) {
//   //     locator.registerLazySingleton<Dio>(() => mockDio);
//   //   }

//   //   if (!locator.isRegistered<GetEpicImageDataSourceImpl>()) {
//   //     locator.registerLazySingleton<GetEpicImageDataSourceImpl>(
//   //         () => GetEpicImageDataSourceImpl(dio: locator<Dio>()));
//   //   }

//   //   dataSource = locator<GetEpicImageDataSourceImpl>();
//   // });

//   late MockDio mockDio;
//   late GetEpicImageDataSourceImpl dataSource;

//   setUp(() {
    

//     mockDio = MockDio();
//     dataSource = GetEpicImageDataSourceImpl(dio: mockDio);
//   });

//   group('GetEpicImageDataSourceImpl Tests', () {
//     test(
//         'debe retornar una lista de EpicImageEntity cuando se recibe una respuesta exitosa',
//         () async {
//       // Arrange
//       when(mockDio.get(endPoint)).thenAnswer((_) async => Response(
//             data: [
//               {
//                 "identifier": "20240512010436",
//                 "caption":
//                     "This image was taken by NASA's EPIC camera onboard the NOAA DSCOVR spacecraft",
//                 "image": "epic_1b_20240512010436",
//                 "version": "03",
//                 "date": "2024-05-12 00:59:48",
//               }
//             ],
//             statusCode: 200,
//             requestOptions: RequestOptions(path: 'some_path'),
//           ));

//       // Act
//       final result = await dataSource.getEpicImage(dia: DateTime(2021, 1, 1));

//       // Assert
//       expect(result, isA<List<EpicImageEntity>>());
//       expect(result.isNotEmpty, true);
//     });
//   });
// }
