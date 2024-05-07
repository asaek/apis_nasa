import '../../entities/entities.dart';

abstract class GetEpicImagesDayRepositorie {
  Future<List<EpicImageEntity>> getEpicImagesDay({required DateTime dia});
}
