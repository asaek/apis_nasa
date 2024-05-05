import 'package:nasa_apis/domain/entities/image_day/image_day_entity.dart';

import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/repositories/repositories.dart';

class GetImageDayRepositorieImpl implements GetImageDayRepositorie {
  final GetOneImageDayDataSource getOneImageDayDataSource;

  GetImageDayRepositorieImpl({required this.getOneImageDayDataSource});

  @override
  Future<List<ImageDayEntitie>> getImageDay({required int cantidadImages}) =>
      getOneImageDayDataSource.getOneImageDay(cantidadImages: cantidadImages);
}
