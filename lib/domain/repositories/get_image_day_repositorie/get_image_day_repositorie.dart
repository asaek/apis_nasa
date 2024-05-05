import '../../entities/entities.dart';

abstract class GetImageDayRepositorie {
  Future<List<ImageDayEntitie>> getImageDay({required int cantidadImages});
}
