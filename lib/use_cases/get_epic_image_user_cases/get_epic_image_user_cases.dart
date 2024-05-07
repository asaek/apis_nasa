import 'package:nasa_apis/domain/repositories/repositories.dart';

import '../../domain/entities/entities.dart';

sealed class GetEpicImageUseCase {
  Future<List<EpicImageEntity>> callGetEpicImage({required DateTime day});
}

class GetEpicImageUseCaseImpl implements GetEpicImageUseCase {
  final GetEpicImagesDayRepositorie getEpicImageRepository;

  GetEpicImageUseCaseImpl({required this.getEpicImageRepository});

  @override
  Future<List<EpicImageEntity>> callGetEpicImage({required DateTime day}) =>
      getEpicImageRepository.getEpicImagesDay(dia: day);
}
