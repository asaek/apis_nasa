import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../use_cases/use_case.dart';

part 'images_menu_principal_state.dart';

class ImagesMenuPrincipalCubit extends Cubit<ImagesMenuPrincipalState> {
  final GetImageDayUseCase getImageDayUseCase;
  ImagesMenuPrincipalCubit({required this.getImageDayUseCase})
      : super(ImagesMenuPrincipalInitial());

  void _loadImages(List<ImageDayEntitie> images) {
    emit(ImagesMenuPrincipalLoaded(images: images));
  }

  void _loading() {
    emit(ImagesMenuPrincipalLoading());
  }

  void cargarImagenes() async {
    _loading();

    final ImageDayEntitie images = await getImageDayUseCase.callGetOneImage();

    print(images);

    // _loadImages(images);
  }
}
