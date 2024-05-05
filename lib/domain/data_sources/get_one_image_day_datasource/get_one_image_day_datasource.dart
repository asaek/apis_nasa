import '../../entities/entities.dart';

abstract class GetOneImageDayDataSource {
  Future<List<ImageDayEntitie>> getOneImageDay({required int cantidadImages});
}
