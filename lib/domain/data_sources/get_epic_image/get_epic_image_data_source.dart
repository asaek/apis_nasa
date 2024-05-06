import '../../entities/entities.dart';

abstract class GetEpicImageDataSource {
  Future<EpicImageEntity> getEpicImage();
}
