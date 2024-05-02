import 'package:nasa_apis/domain/repositories/get_image_day_repositorie/get_image_day_repositorie.dart';

import '../../domain/entities/entities.dart';

sealed class GetImageDayUseCase {
  Future<ImageDayEntitie> callGetOneImage();
}

class GetImageDayUseCaseImpl implements GetImageDayUseCase {
  final GetImageDayRepositorie getOneImageDayRepository;

  GetImageDayUseCaseImpl({required this.getOneImageDayRepository});

  @override
  Future<ImageDayEntitie> callGetOneImage() =>
      getOneImageDayRepository.getImageDay();
}
