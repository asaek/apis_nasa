import 'package:nasa_apis/domain/repositories/get_image_day_repositorie/get_image_day_repositorie.dart';

import '../../domain/entities/entities.dart';

sealed class GetImageDayUseCase {
  Future<List<ImageDayEntitie>> callGetOneImage({required int cantidadImages});
}

class GetImageDayUseCaseImpl implements GetImageDayUseCase {
  final GetImageDayRepositorie getOneImageDayRepository;

  GetImageDayUseCaseImpl({required this.getOneImageDayRepository});

  @override
  Future<List<ImageDayEntitie>> callGetOneImage(
          {required int cantidadImages}) =>
      getOneImageDayRepository.getImageDay(cantidadImages: cantidadImages);
}
