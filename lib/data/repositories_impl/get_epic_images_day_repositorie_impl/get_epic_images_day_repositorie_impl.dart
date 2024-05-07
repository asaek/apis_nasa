import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

class GetEpicImagesDayRepositorieImpl implements GetEpicImagesDayRepositorie {
  final GetEpicImageDataSource datasource;

  GetEpicImagesDayRepositorieImpl({required this.datasource});

  @override
  Future<List<EpicImageEntity>> getEpicImagesDay(
      {required DateTime dia}) async {
    return await datasource.getEpicImage(dia: dia);
  }
}
