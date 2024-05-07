import '../../entities/entities.dart';

abstract class GetEpicImageDataSource {
  Future<List<EpicImageEntity>> getEpicImage({required DateTime dia});
}
