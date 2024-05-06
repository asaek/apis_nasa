import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../use_cases/use_case.dart';

part 'images_menu_principal_state.dart';

class ImagesMenuPrincipalCubit extends Cubit<ImagesMenuPrincipalState> {
  final GetImageDayUseCase getImageDayUseCase;
  ImagesMenuPrincipalCubit({required this.getImageDayUseCase})
      : super(ImagesMenuPrincipalInitial());

  void _loading() {
    emit(ImagesMenuPrincipalLoading());
  }

  void _emitLoadImages(List<ImageDayEntitie> images) {
    emit(ImagesMenuPrincipalLoaded(images: images));
  }

  void loadImagesWithLoading({required int cantidadImages}) async {
    _loading();
    final List<ImageDayEntitie> imagesNew = await getImageDayUseCase
        .callGetOneImage(cantidadImages: cantidadImages);

    _emitLoadImages(imagesNew);
  }

  void loadImagesWithoutLoading({required int cantidadImages}) async {
    final List<ImageDayEntitie> imagesNew = await getImageDayUseCase
        .callGetOneImage(cantidadImages: cantidadImages);

    if (state is ImagesMenuPrincipalLoaded) {
      final loadState = state as ImagesMenuPrincipalLoaded;
      final List<ImageDayEntitie> totalImages = loadState.images + imagesNew;
      _emitLoadImages(totalImages);
      return;
    }

    _emitLoadImages(imagesNew);
  }
}
